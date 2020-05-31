#! /bin/sh

#dbTable,column
#db.member,typ_cd

input=$1

set -x

timeStamp=$(date '+%m%d%Y_%H%M')
hostname='000.000.0.00'

#exec > "log_$timeStamp.txt" 2>&1
#exec 2> "log_$timeStamp.txt" 


echo "profile_type,table_name,column_name,column_value,count" > profile_report.csv

## IFS= option prevent leading/trailing space from being trimmed
## r flag prevent / escape from being interpreted
while IFS= read -r line 
do

# backtick `, not single quote 
dbTable=`echo $line | cut -d "," -f1`
column=`echo $line | cut -d "," -f2`
table=`echo $dbTable|cut -d "." -f2`


echo "select 'top_5_count' as profile, '$table' as table, '$column' as column,$column as value, count(1) as cnt from $dbTable group by $column order by count(1) desc limit 5
union all
select 'bottom_5_count' as profile, '$table' as table, '$column' as column,$column as value, count(1) as cnt from $dbTable group by $column order by count(1) asc limit 5
union all
select 'null_count' as profile, '$table' as table, '$column' as column,$column as value, count(1) as cnt from $dbTable where $column is null group by $column order by count(1) desc limit 5
" > hiveql_profile_query_00584878.sql

result=`beeline -u "jdbs:hive2://$hostname:10000/default;principal=hive/$hostname@domain.com hiveconf mapred.job.queue.name=root.hive"\--showHeader=false --silent=false --outputformat=dsv --delimiterForDSV=',' -f hiveql_profile_query_00584878.sql|sed -E '/^[[:space:]]*$/d' |sed -E 's/ +//g'`

if [ "$result" == ""];
then 
	echo "invalid input line: $line"
else 
	echo $result >> profile_result_$timeStamp.csv
fi



done < "$input"
