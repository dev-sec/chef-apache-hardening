# encoding: utf-8

source 'https://rubygems.org'

gem 'berkshelf',  '~> 8.0'
gem 'chef',       '>= 12.0'
gem 'inspec',     '~> 6'

group :test do
  gem 'rake'
  gem 'chefspec',   '~> 9.3.0'
  gem 'foodcritic', '~> 16.0'
  gem 'thor-foodcritic'
  gem 'rubocop',    '~> 1.65.0'
  gem 'coveralls',  require: false
  gem 'minitest', '~> 5.5'
  gem 'simplecov', '~> 0.10'
end

group :development do
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-kitchen'
  gem 'guard-rubocop'
  gem 'guard-foodcritic'
end

group :integration do
  gem 'test-kitchen', '~> 3.0'
  gem 'kitchen-vagrant'
  gem 'kitchen-inspec'
  gem 'concurrent-ruby', '~> 1.0'
  gem 'kitchen-dokken'
end

group :tools do
  gem 'github_changelog_generator', '~> 1.16.0'
end
