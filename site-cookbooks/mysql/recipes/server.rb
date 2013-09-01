include_recipe "mysql::rpm"

%w(MySQL-server MySQL-devel MySQL-shared).each do |package_name|
  file_name = "#{package_name}-#{node['mysql']['version']}-1.el6.x86_64.rpm"

  package package_name do
    action :install
    provider Chef::Provider::Package::Rpm
    source "/tmp/#{file_name}"
  end
end

template '/etc/my.cnf' do
  source 'my.cnf.erb'
  owner 'root'
  group 'root'
  notifies :restart, "service[mysql]", :delayed
end

service 'mysql' do
  action [:start, :enable]
end

script "Secure_Install" do
  interpreter 'bash'
  user "root"
  not_if "mysql -u root -e 'show databases'"
  code <<-EOL
    export Initial_PW=`head -n 1 /root/.mysql_secret |awk '{print $(NF - 0)}'`
    mysql -u root -p${Initial_PW} --connect-expired-password -e "SET PASSWORD FOR root@localhost=PASSWORD('');"
    mysql -u root -e "SET PASSWORD FOR root@'127.0.0.1'=PASSWORD('');"
    mysql -u root -e "DELETE FROM mysql.user WHERE User='';"
    mysql -u root -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1');"
    mysql -u root -e "DROP DATABASE test;"
    mysql -u root -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';"
    mysql -u root -e "FLUSH PRIVILEGES;"
  EOL
end
