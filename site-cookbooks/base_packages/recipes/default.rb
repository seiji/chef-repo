#
# Cookbook Name:: base_packages
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
%w{sysstat zsh mosh tmux emacs-nox}.each do |pkg|
  package pkg do
    action :install
  end
end
