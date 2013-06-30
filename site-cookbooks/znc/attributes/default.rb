default['znc']['install_method'] = 'package'

case node["platform"]
when "macosx"
  set['znc']['data_dir'] = '$HOME/.znc'
else
  set['znc']['data_dir'] = '/etc/znc'
  set['znc']['user'] = 'znc'
  set['znc']['group'] = 'znc'
end

default['znc']['conf_dir']        = "#{znc['data_dir']}/configs"
default['znc']['log_dir']         = "#{znc['data_dir']}/moddata/adminlog"
default['znc']['module_dir']      = "#{znc['data_dir']}/modules"
default['znc']['users_dir']       = "#{znc['data_dir']}/users"
default['znc']['users']           = Chef::Config[:solo] ? [] : nil

default['znc']['port']            = "+7777"
default['znc']['skin']            = "dark-clouds"
default['znc']['max_buffer_size'] = 500
default['znc']['modules']         = %w{ webadmin adminlog }
