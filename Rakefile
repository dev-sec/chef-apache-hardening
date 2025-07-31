#!/usr/bin/env rake
require 'foodcritic'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

# General tasks

# Rubocop before rspec so we don't lint vendored cookbooks
desc 'Run all tests except Kitchen (default task)'
task default: [:lint, :spec]

# Lint the cookbook
desc 'Run all linters: rubocop and foodcritic'
task lint: [:rubocop, :foodcritic]

# Run the whole shebang
desc 'Run all tests'
task test: [:lint, :integration, :spec]

# RSpec
desc 'Run chefspec tests'
task :spec do
  puts 'Running Chefspec tests'
  RSpec::Core::RakeTask.new(:spec)
end

# Foodcritic
desc 'Run foodcritic lint checks'
task :foodcritic do
  if Gem::Version.new('1.9.2') <= Gem::Version.new(RUBY_VERSION.dup)
    puts 'Running Foodcritic tests...'
    FoodCritic::Rake::LintTask.new do |t|
      t.options = { fail_tags: ['any'] }
      puts 'done.'
    end
  else
    puts "WARN: foodcritic run is skipped as Ruby #{RUBY_VERSION} is < 1.9.2."
  end
end

# Rubocop
desc 'Run Rubocop lint checks'
task :rubocop do
  RuboCop::RakeTask.new
end

# Automatically generate a changelog for this project. Only loaded if
# the necessary gem is installed.

desc 'Generate the changelog'
task :changelog do
  version = File.read('metadata.rb')[/^version '(.*)'$/, 1]
  system "github_changelog_generator -u dev-sec -p chef-apache-hardening --future-release #{version}"
end

namespace :test do
  task :integration do
    concurrency = ENV['CONCURRENCY'] || 1
    os = ENV['OS'] || ''
    sh('sh', '-c', "bundle exec kitchen test -c #{concurrency} #{os}")
  end
end
