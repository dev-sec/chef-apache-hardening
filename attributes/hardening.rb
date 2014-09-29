# encoding: utf-8
#
# Cookbook Name:: apache-hardening
# Attributes:: default
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

# security options

default['apache_hardening']['allowed_http_methods'] = %w( GET POST )
default['apache_hardening']['modules_to_disable'] = %w( cgi cgid )
