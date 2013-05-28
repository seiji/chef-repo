case platform_family
when 'debian', 'rhel', 'amazon'
  default['sysctl']['conf_dir'] = '/etc/sysctl.d'
else
  default['sysctl']['conf_dir'] = nil
end
default['sysctl']['params'] = {}


default['sysctl']['allow_sysctl_conf'] = false

default['sysctl']['params']['fs']['file-max'] = 100000

# Reboot after a kernel panic
default['sysctl']['params']['kernel']['panic'] = 10
# Enable TCP SYN Cookie Protection
default['sysctl']['params']['net']['ipv4']['tcp_syncookies'] = 1

# Don't pass traffic between networks or act as a router
default['sysctl']['params']['net']['ipv4']['forward'] = 0
%w(all defalut).each do |c|
  # Disable IP Source Routing
  default['sysctl']['params']['net']['ipv4']['conf'][c]['accept_source_route'] = 0
  # Enable IP Spoofing Protection
  default['sysctl']['params']['net']['ipv4']['conf'][c]['rp_filter'] = 1
  # Don't allow outsiders to alter the routing tables
  default['sysctl']['params']['net']['ipv4']['conf'][c]['accept_redirects'] = 0
  default['sysctl']['params']['net']['ipv4']['conf'][c]['secure_redirects'] = 0  

  default['sysctl']['params']['net']['ipv4']['conf'][c]['send_redirects'] = 0    
end

# Disable ICMP Redirect Acceptance
default['sysctl']['params']['net']['ipv4']['conf']['all']['accept_redirects'] = 0
# Ignore ICMP Requests
default['sysctl']['params']['net']['ipv4']['icmp_echo_ignore_all'] = 1
default['sysctl']['params']['net']['ipv4']['icmp_echo_ignore_broadcasts'] = 1
# Enable Bad Error Message Protection
default['sysctl']['params']['net']['ipv4']['icmp_ignore_bogus_error_responses'] = 1
%w(all defalut lo).each do |c|
  # Disable IPv6
  default['sysctl']['params']['net']['ipv4']['conf'][c]['disable_ipv6'] = 1
end

default['sysctl']['params']['net']['ipv4']['netfilter']['ip_conntrack_max'] = 1000000
default['sysctl']['params']['net']['ipv4']['ip_local_port_range'] = "1024 65535"

default['sysctl']['params']['net']['core']['somaxconn'] = 40960

# redis
default['sysctl']['params']['vm']['overcommit_memory'] = 1

# network
default['sysctl']['params']['net']['core']['rmem_default'] = 8388608
default['sysctl']['params']['net']['core']['rmem_max'] = 8388608
default['sysctl']['params']['net']['core']['wmem_default'] = 8388608
default['sysctl']['params']['net']['core']['wmem_max'] = 8388608
default['sysctl']['params']['net']['core']['netdev_max_backlog'] = 10000

#default['sysctl']['params']['vm']['swappiness'] = 0


#default['sysctl']['params']['net']['ipv4']['tcp_max_syn_backlog'] = 40000
#default['sysctl']['params']['net']['ipv4']['tcp_timestamps'] = 0
#default['sysctl']['params']['net']['ipv4']['tcp_window_scaling'] = 1
#default['sysctl']['params']['net']['ipv4']['tcp_fin_timeout'] = 15
#default['sysctl']['params']['net']['ipv4']['tcp_keepalive_intvl'] = 30
#default['sysctl']['params']['net']['ipv4']['tcp_tw_reuse'] = 1
