# Vagrant LAMP Stack - Ubuntu 18.04 LTS
A very simple LAMP stack using Ubuntu 18.04 LTS. The idea is for developers to fork this and add additional software and configuration that suits the needs of their project.

## Requirements
* [VirtualBox](https://www.virtualbox.org)
* [Vagrant](https://www.vagrantup.com)

## Installation
Clone this repository:

    $   git clone git@github.com:giuseppetropea/vagrant-lamp-ubuntu-bionic64.git
    
Place your website in the `public` folder.

## Usage
Start the VM
    
    $   cd vagrant-lamp-ubuntu-bionic64
    $   vagrant up
    
You can now access to default Virtual Host at [http://192.168.10.10/](http://192.168.10.10/).

Access to VM:

    $   vagrant ssh
    
Shutdown the VM:

    $   vagrant halt
    
You can find the complete commands list on [Vagrant Docs](https://www.vagrantup.com/docs/).
![Screenshot of up-and-running server](https://i.imgur.com/Myy3NN6.png)

## Installed software
* [Apache 2](https://httpd.apache.org/)
* [MySQL](https://www.mysql.com)
* [PHP 7.2](https://www.php.net/) with mysql, curl, gd, imagick, ecc
* [phpMyAdmin](https://www.phpmyadmin.net/)
* [Composer](https://getcomposer.org/)
* [npm](https://www.npmjs.com/)
* [Git](https://git-scm.com/)

## Default credentials
### MySQL
* Username: root
* Password: root
* Host: localhost
* Port: 3306

**Note:** You can access the MySQL database using phpMyAdmin or your favorite MySQL client with the above credentials.

![phpMyAdmin](https://i.imgur.com/BG5KGSR.png)

## Add Virtual Host
Add your hostname to your local `hosts` file:
    
    $   sudo vi /etc/hosts
    
    ##
    # Host Database
    #
    # localhost is used to configure the loopback interface
    # when the system is booting.  Do not change this entry.
    ##
    127.0.0.1       localhost
    255.255.255.255 broadcasthost
    ::1             localhost
    
    # Vagrant Hostname
    192.168.55.10   giuseppetropea.local
    
Add new Virtual Host to Apache on VM:

From your local machine:

    $   cd vagrant-lamp-ubuntu-bionic64
    $   vagrant up
    $   vagrant ssh
    
From your VM:

    $   sudo vi /etc/apache2/sites-available/giuseppetropea.conf
    
Write your configuration:
    
    <VirtualHost *:80>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html/giuseppetropea/
        ServerName 'giuseppetropea.local'
    
        <Directory "/var/www/html/giuseppetropea/">
            Options FollowSymLinks
            AllowOverride all
            Require all granted
        </Directory>
    
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
    </VirtualHost>
    

Enable your virtual host:

    $ sudo a2ensite giuseppetropea
    $ sudo systemctl reload apache2

![Virtual Host Demo](https://i.imgur.com/X1cX1PD.png)

## Troubleshooting

### Permission error 
If you use a OS X as local machine, you must assign right permission to terminal you use.

From your **System Preferences**, in **Security and Privacy** section, you must add your terminal to:
* Accessibility:

![Accessibility](https://i.imgur.com/pC9drLu.png)

* Full Disk Access:

![Full Disk Access](https://i.imgur.com/KV8Sxdt.png)