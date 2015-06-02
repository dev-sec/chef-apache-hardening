name 'apache-hardening'
maintainer 'Edmund Haselwanter'
maintainer_email 'me@ehaselwanter.com'
license 'Apache v2.0'
description 'Installs and configures a secure apache server'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.9'

depends 'apache2', '~> 2.0.0'

recipe 'apache-hardening::default', 'calls hardening recipe'
recipe 'apache-hardening::hardening', 'add hardening configuration apache server'

supports 'amazon'
supports 'redhat'
supports 'centos'
supports 'fedora'
supports 'debian'
supports 'ubuntu'
supports 'oracle'
