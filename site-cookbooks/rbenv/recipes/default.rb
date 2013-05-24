#
# Cookbook Name:: rbenv
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
group "rbenv" do
  action :create
  members "deploy"
  append true
end

git "/usr/local/rbenv" do
  repository "git://github.com/sstephenson/rbenv.git"
  reference "master"
  action :checkout
  user "#{node.user}"
  group "rbenv"
end

directory "/usr/local/rbenv/plugins" do
  owner "#{node.user}"
  group "rbenv"
  mode "0755"
  action :create
end

template "/etc/profile.d/rbenv.sh" do
  owner "#{node.user}"
  group "#{node.user}"
  mode 0644
end

git "/usr/local/rbenv/plugins/ruby-build" do
  repository "git://github.com/sstephenson/ruby-build.git"
  reference "master"
  action :checkout
  user "#{node.user}"
  group "rbenv"
end
