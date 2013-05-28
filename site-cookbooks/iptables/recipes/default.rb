#
# Cookbook Name:: iptables
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

template "/etc/sysconfig/iptables" do
  source "iptables.erb"
  group "root"
  owner "root"
  mode "0600"
  notifies :restart , 'service[iptables]'
end

service "iptables" do
  supports :status => true, :restart => true
  action [ :enable, :start ]
end
