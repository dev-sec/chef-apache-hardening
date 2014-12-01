# encoding: utf-8

require 'spec_helper'

describe 'apache-hardening::default' do

  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

  before do
    stub_command('/usr/sbin/apache2 -t')
    stub_command("find /etc/apache2 -perm -o+r -type f -o -perm -o+w -type f | wc -l | egrep '^0$'")
  end

  it 'includes apache-hardening::hardening recipe' do
    expect(chef_run).to include_recipe('apache-hardening::hardening')
  end

end
