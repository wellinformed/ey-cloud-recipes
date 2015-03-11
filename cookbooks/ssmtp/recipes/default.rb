require 'pp'
#
# Cookbook Name:: ssmtp
# Recipe:: default
#

if ['solo', 'app', 'util', 'app_master'].include?(node[:instance_role])
    
  Chef::Log.info "The framework environment is #{node[:environment][:framework_env]}"

  directory "/etc/ssmtp" do
    recursive true
    action :delete
  end

  directory "/etc/ssmtp" do
    owner "root"
    group "root"
    mode "0755"
    action :create
    not_if "test -d /etc/ssmtp"
  end

  link "/etc/ssmtp/ssmtp.conf" do
    Chef::Log.info "The framework environment inside link is '#{node[:environment][:framework_env]}'"
    to "/data/citizentest/current/config/ssmtp/#{node[:environment][:framework_env]}.conf"
  end

end
