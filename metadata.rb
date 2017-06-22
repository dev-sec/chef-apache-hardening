name 'apache-hardening'
maintainer 'DevSec Hardening Framework Team'
maintainer_email 'hello@dev-sec.io'
license 'Apache v2.0'
description 'Installs and configures a secure apache server'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.0.0'
source_url 'https://github.com/dev-sec/chef-apache-hardening' if respond_to?(:source_url)
issues_url 'https://github.com/dev-sec/chef-apache-hardening/issues' if respond_to?(:issues_url)

depends 'apache2', '~> 3.2.2'

recipe 'apache-hardening::default', 'calls hardening recipe'
recipe 'apache-hardening::hardening', 'add hardening configuration apache server'

supports 'amazon'
supports 'redhat'
supports 'centos'
supports 'fedora'
supports 'debian'
supports 'ubuntu'
supports 'oracle'
