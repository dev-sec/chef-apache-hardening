# encoding: utf-8
#
# Cookbook Name: apache-hardening
# Recipe: hardening.rb
#
# Copyright 2014, Edmund Haselwanter
# Copyright 2014, Deutsche Telekom AG
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

template File.join(node['apache']['dir'], '/conf-enabled/', 'hardening.conf') do
  action :create
  source 'hardening.cnf.erb'
  owner 'root'
  group node['apache']['root_group']
  mode '0640'
  notifies :restart, 'service[apache2]', :delayed
end

node['apache_hardening']['modules_to_disable'].each do |module_to_disable|
  apache_module module_to_disable do
    enable false
    notifies :restart, 'service[apache2]', :delayed
  end
end

begin
  r = resources(template: "#{node['apache']['dir']}/mods-available/alias.conf")
  r.cookbook('apache-hardening')
rescue Chef::Exceptions::ResourceNotFound
  Chef::Log.info("ignoring update of alias.conf since it is not used #{node['apache']['dir']}/mods-available/alias.conf")
end

# change all the already created resource so we do not flap on o-rw
run_context.resource_collection.each do |resource|
  resource.mode('0640') if resource.name =~ /#{node['apache']['dir']}/ && resource.mode == '0644'
  resource.mode('0750') if resource.name =~ /#{node['apache']['dir']}/ && resource.mode == '0755'
  resource.mode('0640') if resource.name == 'apache2.conf'
end

# change all the other files not defined as resources
execute 'remove world readable files' do
  command "chmod -R o-rw #{node['apache']['dir']}"
  not_if "find #{node['apache']['dir']} -perm -o+r -type f -o -perm -o+w -type f | wc -l | egrep '^0$'"
end
