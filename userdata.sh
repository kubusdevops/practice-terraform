#!/bin/bash

# get admin privileges
sudo su

# install httpd
yum update -y
yum install -y httpd
systemctl start httpd.service
systemctl enable httpd.service
echo "Davops is easy with automation" > /var/www/html/index.html