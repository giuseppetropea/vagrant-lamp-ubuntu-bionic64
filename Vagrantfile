# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    config.vm.box = "ubuntu/bionic64"
    #config.vm.boot_mode = :gui
    config.vm.synced_folder "./projects", "/var/www/html", 
    	type: "nfs"
    config.vm.network "private_network", ip: "192.168.10.10"

    config.vm.provider "virtualbox" do |v|
        v.name = "vagrant_box"
        v.memory = 4096
    end

    config.vm.provision :shell, path: "bootstrap.sh"

end