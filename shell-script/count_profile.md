#! /bin/sh

#db.member,typ_cd
input=$1

set -x

timeStamp=$(date '+%m%d%Y_%H%M')
hostname='192.168.0.41'

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

beeline -u "jdbs:hive2://$hostname:10000/default;principal=hive/$hostname@domain.com"\
--showHeader=false --silent=false --outputformat=dsv --delimiterForDSV=',' -f hiveql_profile_query_00584878.sql|sed -E '/^[[:space:]]*$/d' |sed -E 's/ +//g' > profile_result_$timeStamp.csv

done < "$input"
