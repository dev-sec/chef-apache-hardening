# encoding: utf-8

require 'spec_helper'

describe 'apache-hardening::default' do

  before { allow_any_instance_of(Chef::Recipe).to receive(:search) }
  let(:runner) { ChefSpec::ServerRunner.new }
  let(:node) { runner.node }
  let(:chef_run) { runner.converge(described_recipe) }

  before do
    stub_command('/usr/sbin/apache2 -t')
    stub_command("find /etc/apache2 -perm -o+r -type f -o -perm -o+w -type f | wc -l | egrep '^0$'")
  end

  it 'includes apache-hardening::hardening recipe' do
    expect(chef_run).to include_recipe('apache-hardening::hardening')
  end

end
