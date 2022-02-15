#!/bin/bash
name="vamsi"
s3bucket="upgrad-vamsi/logs"

sudo apt update -y
sudo apt install apache2 -y

serverStatus=$(service apache2 status)
echo $serverStatus
if [[ $serverStatus == *"active (running)"* ]]
then
	echo "Apache server is  running"
else
	sudo service apache2 start
	echo "Apache server started"
fi

if [[ $serverStatus == *"enabled"* ]]
then
	echo "Apache server already enabled"
else	
	sudo sysmtemctl enable apache2
	echo "Apache server enabled"
fi

timestamp=$(date '+%d%m%Y-%H%M%S')

cd /var/log/apache2/
tar -cvf /tmp/${name}-httpd-logs${timestamp}.tar *.log

sudo apt-get install awscli -y
aws s3 \
cp /tmp/${name}-httpd-logs-${timestamp}.tar \
s3://${s3bucket}/${name}-httpd-logs-${timestamp}.tar
