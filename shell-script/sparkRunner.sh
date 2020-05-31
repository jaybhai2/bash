#! /bin/sh

timeStamp=$(date '+%m%d%Y_%H%M')
inputFile=$1
outFile="spark_result_"$timeStamp

echo "Process Id: $$"
echo "Input File: $inputFile"
echo "output File: $outFile"
echo "Running..."

exec 2>"log_"$timeStamp".txt"

hiveql=$(cat $inputFile)

echo "
val sqlContext = new org.apache.spark.sql.hive.HiveContext(sc);
sqlContext.sql(\"\"\"
hiveql
\"\"\").show(10000,false);
System.exit(0);" > sparkql_temp_holder.scala

spark-shell -i sparkql_temp_holder.scala | grep -e '^|.*' | sed -e 's\^|\\g' | sed -e 's\|$\\g' > "$outFile".csv

rm sparkql_temp_holder.scala

lineCnt=$(tail -n +2 "$outFile".csv | wc -l)

#lineCnt=$(wc -l "$outFile".csv | awk '{print $1}')

echo "end"
echo "Return $lineCnt rows in $outFile"
