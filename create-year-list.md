output
```
...
202001
202002
202003
...

```

```
#!/bin/bash

# year_month.sh

start_year=1970
end_year=2015

for year in $( seq ${start_year} ${end_year} ); do
    for month in $( seq 1 12 ); do
        echo ${year}$( echo ${month} | awk '{printf("%02d\n", $1)}');
    done;
done > year_month.csv
```
