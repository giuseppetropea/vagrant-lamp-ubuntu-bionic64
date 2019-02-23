#!/usr/bin/env bash

PASSWORD='root'
HOSTNAME='giuseppetropea.local'

printf "\n--- Running apt Update & Upgrade ---\n"
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade

printf "\n--- Installing Apache ---\n"
sudo apt-get install software-properties-common
sudo apt-get install -y apache2

printf "\n--- Installing MySQL ---\n"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $PASSWORD"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $PASSWORD"
sudo apt-get install -y mysql-server
MYSQL_PWD=$PASSWORD mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$PASSWORD' WITH GRANT OPTION;"
MYSQL_PWD=$PASSWORD mysql -u root -e "FLUSH PRIVILEGES;"

printf "\n--- Installing PHP ---\n"
sudo apt-get install -y php libapache2-mod-php php-mysql php-imagick php-apcu php-redis php-curl php-bz2 php-zip php-mbstring php-intl php-cli php-xml php-gd php-recode php-tidy php-xmlrpc

printf "\n--- Installing phpMyAdmin ---\n"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $PASSWORD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $PASSWORD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $PASSWORD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"
sudo apt install -y phpmyadmin

printf "\n--- Installing Utils and Configurations ---\n"
sudo apt-get install -y composer unzip git npm vim screen

sudo a2enmod rewrite
sudo systemctl reload apache2
sudo systemctl reload mysql

# All Done
printf "\n--- Done: http://192.168.10.10 ---\n"
