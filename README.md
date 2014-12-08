# apache-hardening (Chef cookbook)

[![Supermarket](http://img.shields.io/cookbook/v/apache-hardening.svg)][1]
[![Build Status](http://img.shields.io/travis/TelekomLabs/chef-apache-hardening.svg)][2]
[![Code Coverage](http://img.shields.io/coveralls/TelekomLabs/chef-apache-hardening.svg)][3]
[![Dependencies](http://img.shields.io/gemnasium/TelekomLabs/chef-apache-hardening.svg)][4]

## Description

This cookbook provides a secure overlay for apache configuration.

## Requirements

* chef

## Usage

A sample role may look like:

```json
{
    "name": "apache",
    "default_attributes": { },
    "override_attributes": { },
    "json_class": "Chef::Role",
    "description": "Apache Hardened Server Test Role",
    "chef_type": "role",
    "run_list": [
        "recipe[apt]",
        "recipe[apache2]",
        "recipe[apache-hardening]"
    ]
}
```

## Recipes

### apache-hardening::hardening (default)

This recipe is an overlay recipe for the [apache2 cookbook](https://github.com/viverae-cookbooks/apache2) and applies `apache-hardening::hardening`

Add the following to your runlist and customize security option attributes

```
"recipe[apache2]",
"recipe[apache-hardening]"
```

This hardening recipe installs the hardening but expects an existing installation of Apache2.

## Security Options

* `node['apache']['traceenable'] = 'Off'`
   This directive overrides the behavior of TRACE for both the core server and mod_proxy. 
   See [http://httpd.apache.org/docs/2.2/mod/core.html#traceenable](http://httpd.apache.org/docs/2.2/mod/core.html#traceenable) for details
   Defaults to: `Off`

* `node['apache_hardening']['allowed_http_methods'] = %w( GET POST )`
   A list of HTTP methods that should be allowed in the server. 
   See [http://httpd.apache.org/docs/trunk/mod/mod_allowmethods.html](http://httpd.apache.org/docs/trunk/mod/mod_allowmethods.html) for details
   Defaults to: `GET POST`

* `node['apache_hardening']['modules_to_disable'] = %w( cgi cgid )`
   This parameter sets a list of modules that should be disabled on the target server.
   See [http://httpd.apache.org/docs/current/mod/](http://httpd.apache.org/docs/current/mod/) for details
   Defaults to: `cgi cgid`

## Tests

```
# Install dependencies
gem install bundler
bundle install

# Do lint checks
bundle exec rake lint

# Fetch tests
bundle exec thor kitchen:fetch-remote-tests

# fast test on one machine
bundle exec kitchen test default-ubuntu-1204

# test on all machines
bundle exec kitchen test

# for development
bundle exec kitchen create default-ubuntu-1204
bundle exec kitchen converge default-ubuntu-1204
```

## Contributors + Kudos

* Edmund Haselwanter [ehaselwanter](https://github.com/ehaselwanter)

## Contributing

See [contributor guideline](CONTRIBUTING.md).

## License and Author

* Author:: Deutsche Telekom AG

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.


[1]: https://supermarket.getchef.com/cookbooks/apache-hardening
[2]: http://travis-ci.org/TelekomLabs/chef-apache-hardening
[3]: https://coveralls.io/r/TelekomLabs/chef-apache-hardening
[4]: https://gemnasium.com/TelekomLabs/chef-apache-hardening