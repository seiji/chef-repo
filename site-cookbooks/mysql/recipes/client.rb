include_recipe "mysql::rpm"

package_name = "MySQL-client"
file_name = "#{package_name}-#{node['mysql']['version']}-1.el6.x86_64.rpm"
package package_name do
  action :install
  provider Chef::Provider::Package::Rpm
  source "/tmp/#{file_name}"
end 
