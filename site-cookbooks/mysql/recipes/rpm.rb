%w(MySQL-client MySQL-shared-compat MySQL-server MySQL-devel MySQL-shared).each do |package_name|
  file_name = "#{package_name}-#{node['mysql']['version']}-1.el6.x86_64.rpm"
  remote_uri = "http://dev.mysql.com/get/Downloads/MySQL-5.6/#{file_name}/from/http://cdn.mysql.com/"
  remote_file "/tmp/#{file_name}" do
    source "#{remote_uri}"
  end
end

package_name = "MySQL-shared-compat"
file_name = "#{package_name}-#{node['mysql']['version']}-1.el6.x86_64.rpm"

package package_name do
  action :install
  provider Chef::Provider::Package::Rpm
  source "/tmp/#{file_name}"
end 
