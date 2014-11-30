# encoding: utf-8

require 'spec_helper'

describe 'apache-hardening::hardening' do

  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

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

  it 'executes "remove world readable files"' do

    stub_command("find /etc/apache2 -perm -o+r -type f -o -perm -o+w -type f | wc -l | egrep '^0$'").and_return(false)
    expect(chef_run).to run_execute('remove world readable files')
  end

  it 'does not execute "remove world readable files"' do

    stub_command("find /etc/apache2 -perm -o+r -type f -o -perm -o+w -type f | wc -l | egrep '^0$'").and_return(true)
    expect(chef_run).to_not run_execute('remove world readable files')

  end

end
