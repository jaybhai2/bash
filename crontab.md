
## simulate input stream 
```
mkdir -p /home/sshuser/data/spark-stream/
crontab -e 
```
### put below code into crontab file (this doesnt work b/c spark will only read new file name, try to create a base script and echo to a new file each time)
```
MAILTO=""
PATH="/usr/local/bin:/usr/bin:/bin"

* * * * * echo "hello world" >> /home/sshuser/data/spark-stream/in.data
* * * * * (sleep 10; echo "hello world" >> /home/sshuser/data/spark-stream/in.data)
* * * * * (sleep 20; echo "hello world" >> /home/sshuser/data/spark-stream/in.data)
* * * * * (sleep 30; echo "hello world" >> /home/sshuser/data/spark-stream/in2.data)
* * * * * (sleep 40; echo "hello world" >> /home/sshuser/data/spark-stream/in2.data)
* * * * * (sleep 50; echo "hello world" >> /home/sshuser/data/spark-stream/in2.data)

#* * * * * sh /home/sshuser/data/echo_hello_world.sh
```
### check sys log
```
cat /var/log/syslog | grep 'CRON' | tail -n10

cat /home/sshuser/data/spark-stream/*.data

echo "hello world" > /home/sshuser/data/spark-stream/$(date '+%m%d%Y_%H%M%S').txt
```
