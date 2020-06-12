#!/bin/bash

path=/home/ec2-user/log/

file_name_head=error

file_full_path=$(ls -t1 $path$file_name_head* | head -n1)

file_name=$( echo "${file_full_path}" | rev | cut -d "/" -f1 | rev )

if [ -z $file_name ]
then 
echo "error file not found"
break
fi


modified_tmst=`date -r ${file_full_path} +"%Y%m%d%H%M%S"`
cutoff_tmst=`date --date="24 hours ago" +"%Y%m%d%H%M%S"`

if [[ $modified_tmst -lt $cutoff_tmst ]]

then 

echo "error file not found for last 24 hr, lastest:$file_name at $modified_tmst "

else 
echo "found $file_name at $modified_tmst"

emailed_file_name_head=${file_name: 7}

	if [ "$file_name_head" = "emailed"	]
	then 
	echo "emailed sent already"
	
	else 
	
	
	sample_records=emailed_${file_name%.*}_$(date --date="24 hours ago" +"%Y%m%d%H%M%S")
	
	## sample first 5 row, cut first 255 byte
	head -n5 $file_full_path | cut -b 1-255 > $path$sample_records
	
	echo "error found" | mailx -a $path$sample_records -s "Subject" cops2132@gmail.com
	
	echo "$sample_records emailed"
	
	fi
fi

