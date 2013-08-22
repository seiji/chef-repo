#
# Cookbook Name:: base_packages
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{sysstat zsh mosh tmux emacs-nox
git openssl-devel gcc make gdb sshfs libxml2-devel libxslt-devel
}.each do |pkg|
  package pkg do
    action :install
  end
end

%w[acpid auditd autofs avahi-daemon avahi-dnsconfd bluetooth conman cpuspeed cups dnsmasq dund gpm hidd ip6tables irda lvm2-monitor mcstrans mdmonitor multipathd pand pcscd psacct rawdevices readahead_early readahead_later restorecond saslauthd smartd wpa_supplicant ypbind yum-updatesd].each { |name|
  service name do
    ignore_failure true
    action [:disable, :stop]
  end
}
