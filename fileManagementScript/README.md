### Delete empty file,   if then else if 
```
#! /bin/bash

filename=${1:?Enter file name}

size=$( wc -w < $filename )

echo "size : $size char"

if [ $size -eq 0 ]
then 
rm $filename
echo "file deleted"

else 
echo "file remain"
fi

```

### count 1,+2,+3,+4 ,  while Do Done
```
#! /bin/bash

MAX=10
NUM=1

#set -x

echo "Num: $NUM,  Max: $MAX"
while [[ $NUM -lt $MAX ]]

do
echo $NUM
NUM=$(( NUM + NUM ))

done
```
