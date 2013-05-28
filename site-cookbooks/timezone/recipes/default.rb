#
# Cookbook Name:: timezone
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
require 'chef/util/file_edit'

if ['debian','ubuntu'].member? node[:platform]
  package "tzdata"

  template "/etc/timezone" do
    source "timezone.conf.erb"
    owner 'root'
    group 'root'
    mode 0644
    notifies :run, 'bash[dpkg-reconfigure tzdata]'
  end

  bash 'dpkg-reconfigure tzdata' do
    user 'root'
    code "/usr/sbin/dpkg-reconfigure -f noninteractive tzdata"
    action :nothing
  end
elsif ['rhel','centos','scientific','amazon'].member? node[:platform]
  package "tzdata"

  link "/etc/localtime" do
    to "/usr/share/zoneinfo/#{node[:tz]}"
  end

  clock = Chef::Util::FileEdit.new("/etc/sysconfig/clock")
  clock.search_file_replace_line(/^ZONE=.*$/, "ZONE=\"#{node[:tz]}\"")
  clock.write_file
end
