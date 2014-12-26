![Gogobot Development Box](http://aviioblog.s3.amazonaws.com/gogobot-devbox.png)

# Building a brand new development environment using Chef

## This is NOT Complete yet, come back soon, I am actively working on it

## What does this do?

This will install a local development box on vagrant with the following (among others)

* apt
* python
* java
* openssh
* rbenv
* ruby (2.2.0)
* bundler
* mysql
* mongo
* redis
* memcached
* nodejs
* npm
* juggernaut
* git
* Useful packages like vim/tmux/curl/htop etc...
* Custom .tmux.conf file to better work with tmux (Custom keybindings as well)
* Custom .gitignore

## Prerequisites

* You should have git installed on your machine and configure the SSH key on your github account, it's likely that your project repo is private so this is a crucial step.
* Configure these environment variables on your `ZSH` or `bash` profile.

```shell
# Where is your projects git repository?
export GIT_REPOSITORY_LOCATION='git@github.com:your_user/your_project.git'
# Where should it be cloned to on your machine
export PROJECT_DIR='~/Code/your_project'
# Where should the project be available on the vagrant box
export VAGRANT_PROJECT_DIR='/home/vagrant/gogobot'
# Where did you clone this repository to?
export CHEF_PROJECT_DIR='~/Code/devbox'
# Where is your hostsfile located?
export HOSTS_FILE_LOCATION='/private/etc/hosts'
# Local Network IP for vagrant
export LOCAL_NETWORK_IP='192.168.99.99'
# What's the local domain you'd like to use?
export DOMAIN='local.gogobot.com'
# Vagrant hostname
export HOSTNAME='devbox-avitzurel.gogobot.com'
```

## Installation

* Clone this repository `git clone git@github.com:gogobot/devbox.git
  $CHEF_PROJECT_DIR`
* Clone your project dir `git clone $GIT_REPOSITORY_LOCATION $PROJECT_DIR` and
  then CD into it
* Run `bundle install`
* Run `bin/librarian-chef intall`, This will download all the cookbook
  dependencies into the `/cookbooks` folder
* Run `sudo sh -c "echo '$LOCAL_NETWORK_IP\t$DOMAIN' >> $HOSTS_FILE_LOCATION"`
  in order to add the domain to your hosts file
* Download and install Vagrant from: https://www.vagrantup.com/downloads.html
* Download and install VirtualBox from: https://www.virtualbox.org/wiki/Downloads
* Run `ssh-add -k` This will add your private key to the SSH agent for Vagrant
* Run `vagrant up`
* PROFIT!

## Contributing

 1. Fork it!
 2. Create your feature branch: `git checkout -b my-new-feature`
 3. Commit your changes: `git commit -am 'Add some feature'`
 4. Push to the branch: `git push origin my-new-feature`
 5. Submit a pull request

## Credits

* [@kensodev](http://twitter.com/KensoDev)
* [@kesor6](https://twitter.com/kesor6)

## License

MIT (License file in the repo)