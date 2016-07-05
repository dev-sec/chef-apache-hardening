name 'apache-hardening'
maintainer 'Edmund Haselwanter'
maintainer_email 'me@ehaselwanter.com'
license 'Apache v2.0'
description 'Installs and configures a secure apache server'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.0.0'

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
