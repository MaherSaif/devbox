#
# Cookbook Name:: gogobot-packages
# Recipe:: default
#
# Copyright 2014, Gogobot Ltd.
#
# All rights reserved - Do Not Redistribute
#
# install package dependencies
node['rails']['deploy']['packages'].each { |pkg|
  package pkg
}
