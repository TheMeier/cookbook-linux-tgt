targets = data_bag(node['linux-tgt']['targets_data_bag'])


package node['linux-tgt']['server_package']

svc=node['linux-tgt']['server_service']

service svc do
	supports :restart => true, :reload => true
	provider Chef::Provider::Service::Upstart if platform?('ubuntu') && node['platform_version'].to_f == 14.04
  action [:enable, :start]
end




targets.each do |target|
  current = data_bag_item(node['linux-tgt']['targets_data_bag'],target) 
  if current.key?('id')
    template "/etc/tgt/conf.d/#{current['id']}.conf" do
      source 'target.conf.erb'
      variables({ :params => current })
      notifies :reload, "service[#{svc}]", :delayed
    end
  end
end  
