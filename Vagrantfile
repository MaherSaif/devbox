# -*- mode: ruby -*-
# vi: set ft=ruby :
require "etc"

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"
  config.ssh.private_key_path = [ '~/.vagrant.d/insecure_private_key', '~/.ssh/id_rsa' ]
  config.ssh.forward_agent = true

  config.vm.network "forwarded_port", guest: 80, host: 80
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  config.vm.network "forwarded_port", guest: 3306, host: 3306
  config.vm.network "forwarded_port", guest: 27017, host: 27017

  config.vm.define :devbox do |v|
    v.vm.hostname = ENV['HOSTNAME']
    v.vm.network :private_network, ip: ENV['LOCAL_NETWORK_IP']
  end

  config.nfs.map_uid = Process.uid
  config.nfs.map_gid = Process.gid
  config.vm.synced_folder ENV['PROJECT_DIR'], ENV['VAGRANT_PROJECT_DIR'], nfs: true, create: true

  config.vm.provision :shell do |shell|
    shell.inline = "touch $1 && chmod 0440 $1 && echo $2 > $1"
    shell.args = %q{/etc/sudoers.d/root_ssh_agent "Defaults    env_keep += \"SSH_AUTH_SOCK\""}
  end

  config.vm.provision "shell", path: "vagrant-build.sh"

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["cookbooks", "site-cookbooks"]
    chef.add_recipe 'apt'
    chef.add_recipe 'python'
    chef.add_recipe 'mongodb::default'
    chef.add_recipe 'mysql::client'
    chef.add_recipe 'mysql::server'
    chef.add_recipe 'nodejs'
    chef.add_recipe 'gogobot-redis'
    chef.add_recipe 'git'
    chef.add_recipe 'gogobot-packages'
    chef.add_recipe 'gogobot-java'
    chef.add_recipe 'ulimit'
    chef.add_recipe 'vim'
    chef.add_recipe 'openssh'
    chef.add_recipe 'gogobot-memcache'
    chef.add_recipe 'gogobot-development-box'
    chef.json = {
      :rbenv   => {
        :user_installs => [
          {
            :user   => "vagrant",
            :rubies => [
              "2.2.0",
            ],
            :global => "2.2.0"
          }
        ]
      },
      :mongodb => {
        :dbpath  => "/var/lib/mongodb",
        :logpath => "/var/log/mongodb",
        :port    => "27017"
      },
      :mysql   => {
        :server_root_password   => "password",
        :server_repl_password   => "password",
        :server_debian_password => "password",
        :service_name           => "mysql",
        :basedir                => "/usr",
        :data_dir               => "/var/lib/mysql",
        :root_group             => "root",
        :mysqladmin_bin         => "/usr/bin/mysqladmin",
        :mysql_bin              => "/usr/bin/mysql",
        :conf_dir               => "/etc/mysql",
        :confd_dir              => "/etc/mysql/conf.d",
        :socket                 => "/tmp/mysql.sock",
        :pid_file               => "/var/run/mysqld/mysqld.pid",
        :grants_path            => "/etc/mysql/grants.sql"
      },
      :git     => {
        :prefix => "/usr/local"
      }
    }
  end

  config.vm.provider :virtualbox do |vbox|
    vbox.name = "gogobot-devbox"
    vbox.customize ["modifyvm", :id, "--memory", 4096]
    vbox.customize ["modifyvm", :id, "--cpus", 2]
    vbox.customize ["modifyvm", :id, "--cpuhotplug", "on"]
    vbox.customize ["modifyvm", :id, "--cpuexecutioncap", 85]
    vbox.customize ["modifyvm", :id, "--pae", "on"]
    vbox.customize ["modifyvm", :id, "--ioapic", "on"]
    vbox.customize ["modifyvm", :id, "--acpi", "off"]
    vbox.customize ["modifyvm", :id, "--hwvirtex", "on"]
    vbox.customize ["modifyvm", :id, "--vrde", "off"]
    vbox.customize ["setextradata", :id, "VBoxInternal/Devices/VMMDev/0/Config/GetHostTimeDisabled", "1"]
  end
end