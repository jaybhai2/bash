sudo su

yum update -y

yum install -y httpd.x86_64

systemctl start httpd.service

systemctl enable httpd.service

curl localhost:80

browse the web publicip of the server
