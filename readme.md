### check ip
```
ifconfig -a
curl ifconfig.me
hostname -I
```
### scp secure copy file from local to remote machine,
```
scp data.txt jay@104.211.47.75:~/data/
```
### Set up SSH Tunneling in Windows
1. open putty, enter hostname and port = 22
2. expand menu on left,connect-> SSH -> tunnels 
3. enter source port = 9090, select dynamic, click add.  D9090 will show up in 'forwarded port'
4. go to fire fox, connection setting, 
5. check'Manual proxy configuration' box -> enter SOCKS Host= localhost -> check 'SOCKS v5' box -> check 'Proxy DNS when using SOCKS v5' box
6. whatismyip.com
