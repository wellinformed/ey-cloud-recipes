#
# Cookbook Name:: nginx_cors_fix
# Recipe:: default
#

service "nginx"

if ['app_master', 'app', 'solo'].include?(node[:instance_role])
  node[:applications].each do |app, data|

    template "/tmp/location.block" do
      source 'location.block.erb'
    end

    execute "add header to conf" do
      command "sed -i '/error_log \\/var\\/log\\/engineyard\\/nginx\\/#{app}.error.log notice;/r /tmp/location.block' /etc/nginx/servers/#{app}.conf"
      not_if "grep -q Access-Control-Allow-Origin /etc/nginx/servers/#{app}.conf"

      notifies :reload, resources(:service => ["nginx"]), :delayed
    end

  end
end
