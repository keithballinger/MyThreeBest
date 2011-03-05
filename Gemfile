source 'http://rubygems.org'

#- Basic Rails App
gem 'rails', '>= 3.0.5'
gem 'haml-rails', '>= 0.3.4'
gem 'jquery-rails', '>= 0.2.7'


#- Authentication
gem 'devise', '>= 1.2.rc'
gem 'omniauth', '>= 0.2.0.beta3'


#- M3B Base
gem 'koala', '>= 1.0.0.beta'
gem 'sinatra', '1.1.3'
gem 'resque', '>= 1.13.0'
gem 'resque-status', '>= 0.2.2', :require => 'resque/status'
gem 'typhoeus', '>= 0.2.1'
gem 'yajl-ruby', '>= 0.8.1', :require => 'yajl/json_gem'
gem 'dalli', '>= 1.0.2'
gem 'will_paginate', '>= 3.0.pre2'
gem 'hoptoad_notifier', '>= 2.4.6'

# - Only used in development
group :development do
  gem 'sqlite3-ruby', '>= 1.3.3', :require => 'sqlite3'
  gem 'rails3-generators', '>= 0.17.4'
  gem 'annotate', '>= 2.4.0'
  gem 'hoptoad_notifier', '>= 2.4.6'
  gem 'ruby-debug19', '>= 0.11.6', :require => 'ruby-debug'
  gem 'interactive_editor', '>= 0.0.6'
  gem 'bullet', '>= 2.0.1'
  gem 'ruby-growl', '>= 3.0'
end


# - Only used in production
group :production, :staging do
  gem 'pg', '>= 0.10.1'
end


# - Testing libraries with generators and rake tasks
group :development, :test do
  gem 'rspec-rails', '>= 2.5.0'
  gem 'steak', '>= 1.1.0'
  gem 'thin', '>= 1.2.7'
end


#- For Testing
group :test do
  gem 'shoulda-matchers', '>= 1.0.0.beta1'
  gem 'factory_girl_rails', '>= 1.1.beta1', :require => false
  gem 'mocha', '>= 0.9.11'
  gem 'ffaker', '>= 1.2.0'
  gem 'resque_spec', '>= 0.4.2'

  # Acceptance tests
  gem 'capybara', '>= 0.4.1.2'
  gem 'launchy', '>= 0.3.7'
  gem 'database_cleaner', '>= 0.6.3'
  gem 'fakeweb', '>= 1.3.0'

  # Code metrics
  gem 'metrical', '>= 0.0.4'
  gem 'simplecov', '>= 0.4.1', :require => false

  # Speed up our tests
  gem 'spork', '>= 0.9.0.rc3'
  gem 'guard-spork', '>= 0.1.4'
  gem 'rb-fsevent', '>= 0.3.10'
  gem 'infinity_test', '>= 1.0.2'
end

