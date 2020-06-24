### inline executor using tick ` 
```
date=`date '+%Y%m%d'` 
```

### check ip
```
ifconfig -a
curl ifconfig.me
hostname -I
```
### scp secure copy file from local to remote machine,
```
scp data.txt jay@104.211.47.75:~/data/
// scp -i identity/file/path source target
```
### Set up SSH Tunneling in Windows
1. open putty, enter hostname and port = 22
2. expand menu on left,connect-> SSH -> tunnels 
3. enter source port = 9090, select dynamic, click add.  D9090 will show up in 'forwarded port'
4. go to fire fox, connection setting, 
5. check'Manual proxy configuration' box -> enter SOCKS Host= localhost -> check 'SOCKS v5' box -> check 'Proxy DNS when using SOCKS v5' box
6. whatismyip.com
7. 0.0.0.0:8080


### rename file with pattern
```
for f in *.csv; do mv "$f" "$(echo "$f" | sed s/IMG/VACATION/)"; done
```
### nohup
```
#nohup job must end with a '&' to tell it to run in background
nohup bin/zookeeper-server-start.sh config/zookeeper.properties > ~/nohup.out 2> ~/nohup.err < /dev/null &
# send standard out to home/nohup.out and send standard error to home/nohup.err
# jobs -l # to list running nohup job in current shell session. OR ps -ef | grep "nohup "
# jps -l
```

### list port lisener 
```
In window 
netstat -ano | find "8080"
  TCP    0.0.0.0:8080           0.0.0.0:0              LISTENING       8132
  TCP    [::]:8080              [::]:0                 LISTENING       8132

taskkill /pid 18264 /f

Linux

netstat -nap | grep 8080

```
### add user
```
sudo adduser jay
# provider sudo priviledge
sudo usermod -aG sudo jay


```
