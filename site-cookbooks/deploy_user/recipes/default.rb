#
# Cookbook Name:: deploy_user
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
user 'deploy' do
  shell    '/bin/zsh'
  supports :manage_home => false, :non_unique => false
  home     '/var/www'
  action   [:create]
end

