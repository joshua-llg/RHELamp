#!/bin/bash


#get the necessary rpms for Lamp server
 sudo dnf install httpd mariadb php-fpm
#allow service http & https
 sudo firewall-cmd --permanent --zone=public --add-service=http 
 sudo firewall-cmd --permanent --zone=public --add-service=https
 sudo firewall-cmd --reload

#start httpd & and mariadb temporarely
 sudo systemctl start httpd 
 sudo systemctl start mariadb 

FILE="/home/success"
#setup secure mysql database && stop httpd and mariadb
 sudo mysql_secure_installation
echo ""
echo ""
#temporarely stops httpd/mariadb and redirects success input into success file
 sudo systemctl stop httpd
 sudo systemctl stop mariadb 0>> /home/success
#checks to see if success file exist
if [[ -f $FILE ]];then
	 echo -e "  Lamp install was a successful,\nnow make Server script an executable\n    and sudo ./server up/down "
	 echo ""	 
fi

sudo rm -rf /home/success
exit

