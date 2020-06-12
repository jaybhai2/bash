
path=/home/ec2-user/
file_name_starting=log_response

# list all matching file by modified date desc and fetch first one
src_file=$(ls -t1 $path$file_name_starting* | head -n1)


tgt_path=/home/ec2-user/staging/
tgt_file=tgt.txt

cp $src_file $tgt_path$tgt_file
