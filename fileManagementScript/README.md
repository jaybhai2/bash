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

### if elif else
```
#! /bin/bash

file=${1:?Please enetr a file name}
if [ ! -e "$file" ];then
 echo "$file doest not exist" ;exit 1
elif [ -d "$file" ];then
 echo "$file is a directory" ;exit 1
else echo "$file might be ok..."
fi
cat $file
```



### count 1,+2,+3,+4 , While Do Done
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
### while read line
```
#! /bin/bash

FILE=${1:?Enter a file to read}
while read -r line
do 
echo "I am excited to learn about $line " > DataEng/${line}.txt
#if [ ! -z "$line" ]
 echo "txt file $line created"
#fi
done < "$FILE"

```
### compare number
```
#!/bin/bash

num1=$1
num2=$2
if [ $num1 -eq $num2 ]; then echo $num1 is equal to $num2
elif [ $num1 -lt $num2 ]; then echo $num1 is less than $num2
else echo $num1 is greater than to $num2
fi
```

### User input, read

```
#! /bin/bash

read first last

echo "hello $first $last"
```
### 
```
#! /bin/bash
echo "Please enter your name and press enter"
read name
echo "Please enter your age and press enter"
read age
echo "Please enter your height and press enter"
read height
echo "Please enter your eye color and press enter"
read eyecolor
echo "Please enter your hair color and press enter"
read haircolor

echo "Here is the information you entered"
echo Let\'s talk about ${name}. It is $age years old. Its $height tall. It has $eyecolor eyes and $haircolor haid. If I add its age and height, i get $[age+height] .

```

### check is file is a directory
```
#! /bin/bash
for FILE in $1 $2 $3 

do

if [ -d "$FILE" ] ; then
 echo "$FILE is a directory"
fi

done

```

