case platform_family
when 'debian', 'rhel', 'amazon'
  default['sysctl']['conf_dir'] = '/etc/sysctl.d'
else
  default['sysctl']['conf_dir'] = nil
end
default['sysctl']['params'] = {}
default['sysctl']['allow_sysctl_conf'] = false

default['sysctl']['params']['fs']['file-max'] = 100000
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
