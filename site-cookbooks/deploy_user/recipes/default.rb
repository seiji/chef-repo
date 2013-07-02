#
# Cookbook Name:: deploy_user
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
node_user  = node['deploy_user']['user']
node_group = node['deploy_user']['group']

user node_user
group node_group

group "wheel" do
  action [:modify]
  members [node_user]
  append true
end

[ node['deploy_user']['data_dir'],
].each do |dir|
  directory dir do
    owner node_user
    group node_group
  end
end

user = node['etc']['passwd'][node_user]
user = {'uid' => node_user, 'gid' => node_user, 'dir' => "/home/#{node_user}"} unless user
if user and user['dir'] and user['dir'] != "/dev/null"
  data = data_bag_item('users', node_user)
  ssh_keys = []
  if data and data['ssh_keys']
    ssh_keys += Array(data['ssh_keys'])
    home_dir = user['dir']
    authorized_keys_file = "#{home_dir}/.ssh/authorized_keys"

    if File.exist?(authorized_keys_file)
      Chef::Log.info("Keep authorized keys from: #{authorized_keys_file}")
      
      # Loading existing keys
      File.open(authorized_keys_file).each do |line|
        if line.start_with?("ssh")
          ssh_keys += Array(line.delete "\n")
        end
      end
      ssh_keys.uniq!

    else
      directory "#{home_dir}/.ssh" do
        owner user['uid']
        group user['gid'] || user['uid']
        mode "0700"
      end
    end

    template authorized_keys_file do
      owner user['uid']
      group user['gid'] || user['uid']
      mode "0600"
      variables :ssh_keys => ssh_keys
    end
  end

end
