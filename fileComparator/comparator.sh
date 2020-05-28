#!/bin/bash

#sh Comparator.sh <outPutPath> <srcFile> <tgtFile> <srcDelimiter> <tgtDelimiter> <primaryKeyColumn> <primaryKeyColumnWithDollarSign> <srcFileSystem> <tgtFileSystem> <srcColumnList> <tgtColumnList>


outPutPath=$1
srcFile=$2
tgtFile=$3
srcDelimiter=$4
tgtDelimiter=$5
primaryKeyColumn=$6
primaryKeyColumn2=$7     #  \$primaryKeyColumn
srcFileSystem=$8  		#Local or HDFS
tgtFileSystem=$9
srcColumnList=${10}
tgtColumnList=${11}	#1-6 -> 1st col to 6th coln or 1,2,3,4,5,6
newDelimiter="|"

#Print commands and their arguments as they are executed
#set -x  

printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =

echo "outout path: $outPutPath" 
echo "source: $srcFile" 
echo "target: $tgtFile" 
echo "source delimiter: $srcDelimiter" 
echo "target delimiter: $tgtDelimiter" 
echo "primary key: $primaryKeyColumn" 
echo "source system: $srcFileSystem" 
echo "target system: $tgtFileSystem"

printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =

mkdir -p "$outPutPath"


echo "Source file extraction, replacing delimiter"
if [ "$srcFileSystem" = "Local" ]
	then
		cat $srcFile | sed 's/'$srcDelimiter'/'$newDelimiter'/g' > "$outPutPath"/staging/src_changed_delimiter.csv
		
elif [ "$srcFileSystem" = "HDFS" ]
	then
		hadoop fs -copyToLocal $srcFile > $outPutPath/temp_src_raw.csv
		cat $outPutPath/temp_src_raw.csv | sed 's/'$srcDelimiter'/'$newDelimiter'/g' > '$outPutPath'/staging/src_changed_delimiter.csv
fi


echo "Target file extraction, replacing delimiter"
if [ "$tgtFileSystem" = "Local" ]
	then
		cat $tgtFile | sed 's/'$tgtDelimiter'/'$newDelimiter'/g' > "$outPutPath"/staging/tgt_changed_delimiter.csv
		
elif [ "$tgtFileSystem" = "HDFS" ]
	then
		hadoop fs -copyToLocal $srcFile > $outPutPath/staging/temp_tgt_raw.csv
		cat $outPutPath/temp_tgt_raw.csv | sed 's/'$tgtDelimiter'/'$newDelimiter'/g' > '$outPutPath'/staging/tgt_changed_delimiter.csv
fi

#Select user specified columns list for comparison  
if [ "$#" == "11" ]
	then 
		echo "User defined column list selected"
		cut -d "$newDelimiter" -f "$srcColumnList" "$outPutPath"/src_changed_delimiter.csv > "$outPutPath"/staging/src.csv
		cut -d "$newDelimiter" -f "$srcColumnList" "$outPutPath"/tgt_changed_delimiter.csv > "$outPutPath"/staging/tgt.csv

elif [ "$#" == "12" ]
	then 
		cut -d "$newDelimiter" -f "$srcColumnList" "$outPutPath"/src_changed_delimiter.csv > "$outPutPath"/staging/src.csv
		cut -d "$newDelimiter" -f "$tgtColumnList" "$outPutPath"/tgt_changed_delimiter.csv > "$outPutPath"/staging/tgt.csv
else 
	mv "$outPutPath"/src_changed_delimiter.csv "$outPutPath"/staging/tgt.csv
	mv "$outPutPath"/tgt_changed_delimiter.csv "$outPutPath"/staging/src.csv
fi

#Sorting

sort -t "$newDelimiter" "$outPutPath"/tgt.csv > "$outPutPath"/sorted_tgt.csv
sort -t "$newDelimiter" "$outPutPath"/src.csv > "$outPutPath"/sorted_src.csv

#Extract Primary Key
cut -d "$newDelimiter" -f $primaryKeyColumn "$outPutPath"/sorted_tgt.csv > "$outPutPath"/tgt_pk.csv
cut -d "$newDelimiter" -f $primaryKeyColumn "$outPutPath"/sorted_src.csv > "$outPutPath"/src_pk.csv

#Duplicate check on Primary Key
uniq -c -d "$outPutPath"/sorted_src.csv > "$outPutPath"/src_duplicate.csv  
uniq -c -d "$outPutPath"/sorted_tgt.csv > "$outPutPath"/tgt_duplicate.csv 


awk -F"$newDelimiter" 'NR==FNR{++a[$0];next} !($0 in a)' "$outPutPath"/sorted_src.csv "$outPutPath"/sorted_tgt.csv > "$outPutPath"/tgt_minus_src_pk.csv

awk -F"$newDelimiter" 'NR==FNR{++a[$0];next} !($0 in a)' "$outPutPath"/sorted_tgt.csv "$outPutPath"/sorted_src.csv > "$outPutPath"/src_minus_tgt_pk.csv

awk -F"$newDelimiter" 'NR==FNR{++a['$primaryKeyColumn2'];next} '$primaryKeyColumn2' in a' "$outPutPath"/sorted_src.csv "$outPutPath"/sorted_tgt.csv > "$outPutPath"/common_row.csv

awk -F"$newDelimiter" 'NR==FNR{++a['$primaryKeyColumn2'];next} '$primaryKeyColumn2' in a' "$outPutPath"/sorted_tgt.csv "$outPutPath"/sorted_src.csv > "$outPutPath"/common_src.csv.

paste -d "$newDelimiter" "$outPutPath"/sorted_src.csv "$outPutPath"/sorted_tgt.csv > "$outPutPath"/paste.csv

paste -d "$newDelimiter" "$outPutPath"/sorted_src.csv "$outPutPath"/sorted_tgt.csv | awk -F "$newDelimiter" '{c=NF/2; for(i=1;i<=c;i++)if(($i!="") && ($(i+x)==""))printf "line_%-5s,mismatch_on_col=%-5s,src_val=%s,tgt_val=%s \n",NR,i,$i,$(i+c)}' > "$outPutPath"/null_record_match.csv

paste -d "$newDelimiter" "$outPutPath"/sorted_src.csv "$outPutPath"/sorted_tgt.csv | awk -F "$newDelimiter" '{c=NF/2; for(i=1;i<=c;i++) { src=$i "";tgt=$(i+c) ""; if(src != tgt) printf "line_%-5s,mismatch_on_col=%-5s,src_val=%s,tgt_val=%s \n",NR,i,$i,$(i+c)}}' > "$outPutPath"/match_result.csv

rm "$outPutPath"/staging/src_changed_delimiter.csv "$outPutPath"/tgt_changed_delimiter.csv 

if [ "$#" == "11" ]
	then 
		rm "$outPutPath"/staging/src.csv "$outPutPath"/staging/tgt.csv 
else
	rm "$outPutPath"/temp_src.csv "$outPutPath"/temp_tgt.csv 
fi







