#!/bin/bash

#Variable Declaration
#PACKAGE="httpd wget unzip"
#SVC="httpd"
URL="https://www.tooplate.com/zip-templates/2098_health.zip"
ART_NAME='2098_health'
TEMPDIR="/tmp/webfiles" 

yum --help &> /dev/null
if [ $? -eq 0 ]
then 
	PACKAGE="httpd wget unzip"
	SVC="httpd"
	echo "Running Setup on CentOS"
	#Installing Dependencies
	echo "----------------"
	echo "Installing packages."
	sudo yum install $PACKAGE -y > /dev/null
	echo

	#Start & Enable Service
	systemctl start $SVC
	systemctl enable $SVC
	
	echo "----------------"
	
	echo "Dir changed"
	mkdir /tmp/new_dir
	cd /tmp/new_dir
	
	echo "----------------"
	echo "Downloading pkgs"
	wget $URL > /dev/null
	
	echo "----------------"
	echo "Unzipping files"
	unzip $ART_NAME.zip > /dev/null
	sudo cp -r $ART_NAME/* /var/www/html/
	echo
	
	echo "----------------"
	echo "Restarting the service"
	systemctl restart $SVC
	systemctl stop firewalld
	echo
	
	echo "---------------"
	echo "Deleting files"
	cd
	rm -rf /tmp/new_dir
	echo
	echo "Done"
	echo "---------------"
	echo "Please check at"
	#ip -a | grep -i 192.168*
	ls /var/www/html
else
	PACKAGE="apache2 wget unzip"
        SVC="apache2"
        echo "Running Setup on CentOS"
        #Installing Dependencies
        echo "----------------"
        echo "Installing packages."
	sudo apt update > /dev/null
        sudo apt install $PACKAGE -y > /dev/null
        echo 

        #Start & Enable Service
        systemctl start $SVC
        systemctl enable $SVC

        echo "----------------"

        echo "Dir changed"
        mkdir /tmp/new_dir 
        cd /tmp/new_dir 
        
        echo "----------------"
        echo "Downloading pkgs"
        wget $URL > /dev/null
        
        echo "----------------"
        echo "Unzipping files"
        unzip $ART_NAME.zip > /dev/null
        sudo cp -r $ART_NAME/* /var/www/html/
        echo

        echo "----------------"
        echo "Restarting the service"
        systemctl restart $SVC
	systemctl stop firewalld
        echo
        
        echo "---------------"
        echo "Deleting files"
        cd 
        rm -rf /tmp/new_dir
        echo
        echo "Done"
        echo "---------------"
        echo "Please check at"
        ip -a | grep -i 192.168*
	ls /var/www/html
fi
