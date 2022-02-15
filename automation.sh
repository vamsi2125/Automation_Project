#!/bin/bash
name="vamsi"
s3bucket="upgrad-vamsi"

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

if [ -e /var/www/html/inventory.html ]
then
        echo "Inventory exists"
else
        touch /var/www/html/inventory.html
        echo "<b>Log Type &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Date Created &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Type &nbsp;&nbsp;$
fi
echo "<br>httpd-logs &nbsp;&nbsp;&nbsp;&nbsp; ${timestamp} &nbsp;&nbsp;&nbsp;&nbsp; tar &nbsp;&nbsp;&nbsp;&nbsp; `du -h $
if [ -e /etc/cron.d/automation ]
then
        echo "Cron job exists"
else
        touch /etc/cron.d/automation
        echo "0 0 * * * root /root/Automation_Project/automation.sh" > /etc/cron.d/automation
        echo "Cron job added"
fi
