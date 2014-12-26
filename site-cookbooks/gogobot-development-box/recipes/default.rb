#
# Cookbook Name:: gogobot-development-box
# Recipe:: default
#
# Copyright 2014, Gogobot Ltd.
#
# All rights reserved - Do Not Redistribute
#
#
include_recipe "rbenv::default"
include_recipe "rbenv::ruby_build"

# install useful packages
%w{ curl htop lsof sysstat tmux mailutils }.each do |pkg|
  package pkg
end

template "#{node['devbox']['user_home']}/.tmux.conf" do
  source 'tmux.conf.erb'
  owner 'vagrant'
  group 'vagrant'
end

template "#{node['devbox']['user_home']}/.gitignore" do
  source 'gitignore.erb'
  owner 'vagrant'
  group 'vagrant'
end

rbenv_ruby "#{node['rbenv']['user_installs']['global']}" do
  ruby_version node['rbenv']['user_installs']['global']
  global true
end

rbenv_gem "bundler" do
  ruby_version node['rbenv']['user_installs']['global']
  action :install
end

execute "sudo -i -u vagrant bundle install --gemfile=#{node['devbox']['project_root']}/Gemfile --path #{node['devbox']['user_home']}/.bundle"

nodejs_npm 'juggernaut'
