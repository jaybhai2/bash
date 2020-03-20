sudo su

yum update -y

yum install -y httpd.x86_64

systemctl start httpd.service

systemctl enable httpd.service

curl localhost:80

curl ifconfig.me

place any index.html to /var/www/html/

change security group setting, add http inbound

```
rpm -ql httpd.x86_64 | grep 'bin'
```
