#
# Cookbook Name:: znc
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
Chef::Log.level = :debug
include_recipe "znc::#{node['znc']['install_method']}"

user node['znc']['user']
group node['znc']['group']

[ node['znc']['data_dir'],
  node['znc']['conf_dir'],
  node['znc']['module_dir'],
  node['znc']['users_dir']
].each do |dir|
  directory dir do
    owner node['znc']['user']
    group node['znc']['group']
  end
end

bash "generate-pem" do
  cwd node['znc']['data_dir']
  code <<-EOH
  umask 077
  openssl genrsa 2048 > znc.key
  openssl req -subj /C=US/ST=Several/L=Locality/O=Example/OU=Operations/CN=#{node['fqdn']}/emailAddress=znc@#{node['fqdn']} \
   -new -x509 -nodes -sha1 -days 3650 -key znc.key > znc.crt
  cat znc.key znc.crt > znc.pem
  EOH
  user node['znc']['user']
  group node['znc']['grouip']
  creates "#{node['znc']['data_dir']}/znc.pem"
end

template "/etc/init.d/znc" do
  source "znc.init.erb"
  owner "root"
  group "root"
  mode "0755"
end

users =  node['znc']['users'] || search(:users, 'groups:znc')

# znc doesn't like to be automated...this prevents a race condition
# http://wiki.znc.in/Configuration#Editing_config
execute "force-save-znc-config" do
  command "pkill -SIGUSR1 znc"
  action :run
  only_if "pgrep znc"
end

execute "reload-znc-config" do
  command "pkill -SIGHUP znc"
  action :nothing
  only_if "pgrep znc"
end

# render znc.conf
template "#{node['znc']['data_dir']}/configs/znc.conf" do
  source "znc.conf.erb"
  mode 0600
  owner node['znc']['user']
  group node['znc']['group']
  variables(
            :users => users
            )
  notifies :run, "execute[reload-znc-config]", :immediately
end

service "znc" do
  supports :restart => true
  action [:enable, :restart]
end
