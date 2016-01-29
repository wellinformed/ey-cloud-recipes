if ['app_master', 'app', 'solo'].include?(node[:instance_role])
  node[:engineyard][:environment][:apps].each do |app|

    # create new database.yml
    template "/data/#{app[:name]}/shared/config/vanity.yml" do
      source 'vanity.yml.erb'
      owner node[:users][0][:username]
      group node[:users][0][:username]
      mode 0644
      variables({
        :environment => node[:environment][:framework_env],
        :adapter => 'mysql2',
        :database => app[:database_name],
        :username => node[:users][0][:username],
        :password => node[:users][0][:password],
        :host => node[:db_host]
      })
    end
  end
end
# end
