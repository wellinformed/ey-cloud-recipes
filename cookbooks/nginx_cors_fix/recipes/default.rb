#
## Cookbook Name:: nginx_cors_fix
## Recipe:: default
##
#
service "nginx" do
  supports reload: true
end

if ['app_master', 'app', 'solo'].include?(node[:instance_role])
  node[:applications].each do |app, data|
    template "/data/nginx/servers/theorytest/custom.conf" do
      source 'location.block.erb'
      owner node[:owner_name]
      group node[:owner]
      notifies :reload, resources(:service => "nginx")
    end
  end
end
