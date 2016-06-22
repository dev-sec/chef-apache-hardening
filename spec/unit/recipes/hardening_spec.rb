# encoding: utf-8

require 'spec_helper'

describe 'apache-hardening::hardening' do

  before { allow_any_instance_of(Chef::Recipe).to receive(:search) }
  let(:runner) { ChefSpec::ServerRunner.new }
  let(:node) { runner.node }
  let(:chef_run) { runner.converge(described_recipe) }

  before do
    stub_command('/usr/sbin/apache2 -t')
    stub_command("find /etc/apache2 -perm -o+r -type f -o -perm -o+w -type f | wc -l | egrep '^0$'")
  end

  it 'creates hardening.conf with correct permissions' do

    expect(chef_run).to create_template(File.join(chef_run.node['apache']['dir'], '/conf-enabled/', 'hardening.conf')).with(
      user:   'root',
      group:  chef_run.node['apache']['root_group'],
      mode:   '0640'
    )

  end

  # Since we cannot test the definition apache_module itself, we have to test for a side effect to happen
  # We check for the not present module file in mods_enabled
  it 'disables specified apache modules' do

    chef_run.node['apache_hardening']['modules_to_disable'].each do |module_to_disable|
      expect(chef_run).to_not create_file_if_missing("#{chef_run.node['apache']['dir']}/mods-enabled/#{module_to_disable}.load")
    end

  end

  it 'checks that the correct alias.conf.erb template is being used' do

    chef_run.run_context.resource_collection.each do |resource|

      next unless resource.name == "#{chef_run.node['apache']['dir']}/mods-available/alias.conf"

      expect(resource.cookbook).to eq('apache-hardening')

    end

  end

  it 'makes sure that it does not flap on o-rw' do

    chef_run.run_context.resource_collection.each do |resource|

      next unless (resource.respond_to? :mode) && !resource.mode.nil?

      expect(resource.mode).to eq('0750') if resource.name =~ /#{chef_run.node['apache']['dir']}/ && resource.mode[1].eql?('7')
      expect(resource.mode).to eq('0640') if resource.name =~ /#{chef_run.node['apache']['dir']}/ && resource.mode[1].eql?('6')
      expect(resource.mode).to eq('0640') if resource.name == 'apache2.conf'

    end

  end

  it 'executes "remove world readable files"' do

    stub_command("find /etc/apache2 -perm -o+r -type f -o -perm -o+w -type f | wc -l | egrep '^0$'").and_return(false)
    expect(chef_run).to run_execute('remove world readable files')

  end

  it 'does not execute "remove world readable files"' do

    stub_command("find /etc/apache2 -perm -o+r -type f -o -perm -o+w -type f | wc -l | egrep '^0$'").and_return(true)
    expect(chef_run).to_not run_execute('remove world readable files')

  end

end
