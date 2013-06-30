configure_options = node['znc']['configure_options'].join(" ")

include_recipe 'build-essential'

pkgs = value_for_platform(
                          [ "debian", "ubuntu" ] =>
                          {"default" => %w{ libssl-dev libperl-dev pkg-config libc-ares-dev }},
                          "default" => %w{ libssl-dev libperl-dev pkg-config libc-ares-dev }
                          )

pkgs.each do |pkg|
  package pkg do
    action :install
  end
end

version = node['znc']['version']

remote_file "#{Chef::Config[:file_cache_path]}/znc-#{version}.tar.gz" do
  source "#{node['znc']['url']}/znc-#{version}.tar.gz"
  checksum node['znc']['checksum']
  mode "0644"
  not_if "which znc"
end

bash "build znc" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOF
  tar -zxvf znc-#{version}.tar.gz
  (cd znc-#{version} && ./configure #{configure_options})
  (cd znc-#{version} && make && make install)
  EOF
  not_if "which znc"
end
