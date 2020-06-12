#!/bin/bash

path=/home/ec2-user/shell-scripts/
file_name_head=log

file_list=$(ls -t $path$file_name_head*)

new_path=/home/ec2-user/log/
mkdir $new_path

for f in $file_list
do 
  echo $f
  
  #get file name, remove path, rev=reverse line
  file_name=$( echo "${f}" | rev | cut -d "/" -f1 | rev )
  echo $file_name
  
  #remove file extension
  file_name_short=$(echo "${file_name%.*}")
  
  timestamp=`date "+%Y%m%d%H%M%S"`
  
  new_name=${file_name_short}${timestamp}.log
  
  cp $f $new_path$new_name
  
done
