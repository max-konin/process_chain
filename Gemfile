# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

# Specify your gem's dependencies in process_chain.gemspec
gemspec


group :development, :test do
  gem 'bundler'
  gem 'rake'
  gem 'rubocop', '0.51.0'
  gem 'yard'
end

group :test do
  gem 'coveralls', '~> 0.8.17', require: false
  gem 'rspec', '~> 3.0'
end
