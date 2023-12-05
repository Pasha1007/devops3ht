#!/bin/bash 
#Оновлення пакетів
sudo yum update -y 
sudo yum install mc vim git httpd cronie -y 
sudo service httpd start 
sudo systemctl enable httpd 

#Виводить поточну дату
echo 'date >> /var/log/sysinfo'
#Інформація про вхідні підключення
echo 'w >> /var/log/sysinfo' 
#Інформація про використання пам`яті
echo 'free -m >> /var/log/sysinfo' 
#Інформація про використання місця на диску
echo 'df -h >> /var/log/sysinfo' 
#Інформацію про відкриті мережеві порти та програми
echo 'ss -tulpn >> /var/log/sysinfo' 
#Ping до "ukr.net"
echo 'ping -c1 -w1 ukr.net >> /var/log/sysinfo' 

echo 'find / -type f -perm /4000 >> /var/log/sysinfo' >> /root/sysinfo.sh
 
#Робить скріпт можливим для запуску
chmod -v +x /root/sysinfo.sh &>/tmp/chmod.log 
#Sysinfo тепер запускається кожної хвилини з Понеділка по П`ятницю    
echo ' * * * * 1-5 root /root/sysinfo.sh' >> /etc/crontab 
 
sudo service crond restart