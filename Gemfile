source :rubygems

#- Basic Rails App
gem 'rails', '3.1.0.rc1'
gem 'haml-rails', '>= 0.3.4'
gem 'jquery-rails', '>= 0.2.7'
gem 'rake', '0.8.7'

#- Authentication
gem 'devise', '>= 1.3.0'
gem 'oa-core', '>= 0.2.1', :require => 'omniauth/core'
gem 'oa-oauth', '>= 0.2.1', :require => 'omniauth/oauth'

#- M3B Base
gem 'koala', '>= 1.0.0'
gem 'resque', '>= 1.15.0'
gem 'resque-status', '>= 0.2.2', :require => 'resque/status'
gem 'resque_mailer', '>= 1.0.1'
gem 'typhoeus', '>= 0.2.4'
gem 'yajl-ruby', '>= 0.8.2', :require => 'yajl/json_gem'
gem 'dalli', '>= 1.0.3'
gem 'hoptoad_notifier', '>= 2.4.9'
gem 'simple_form', '>= 1.3.1'
gem 'kaminari', '>= 0.10.4'
gem 'resque-heroku-autoscaler', '>= 0.2.3'
gem 'hirefireapp'

# - Only used in development
group :development do
  gem 'sqlite3-ruby', '>= 1.3.3', :require => 'sqlite3'
  gem 'rails3-generators', '>= 0.17.4'
  gem 'annotate', '>= 2.4.0'
  gem 'ruby-debug19', '>= 0.11.6', :require => 'ruby-debug'
  gem 'interactive_editor', '>= 0.0.8'
  #gem 'bullet', '>= 2.0.1'
  gem 'ruby-growl', '>= 3.0'
end


# - Only used in production
group :production, :staging do
  gem 'pg', '>= 0.10.1'
end


# - Testing libraries with generators and rake tasks
#group :development, :test do
#  gem 'rspec-rails', '>= 2.5.0'
#  gem 'thin', '>= 1.2.7'
#end


#- For Testing
group :development, :test do
  gem 'rspec-rails', '>= 2.5.0'
  gem 'thin', '>= 1.2.7'
  gem 'shoulda-matchers', '>= 1.0.0.beta1'
  gem 'factory_girl_rails', '>= 1.1.beta1', :require => false
  gem 'mocha', '>= 0.9.11'
  gem 'ffaker', '>= 1.2.0'
  gem 'resque_spec', '>= 0.4.2'

  #- Acceptance tests
  gem 'capybara', '~> 1.0.0.beta1'
  gem 'capybara-webkit', '>= 1.0.0.beta1'
  gem 'launchy', '>= 0.3.7'
  gem 'database_cleaner', '>= 0.6.6'
  gem 'fakeweb', '>= 1.3.0'

  #- Code metrics
  gem 'metrical', '>= 0.0.4'
  gem 'simplecov', '>= 0.4.1', :require => false

  #- Speed up our tests
  gem 'spork', '>= 0.9.0.rc4'
  gem 'guard-spork', '>= 0.1.6'
  gem 'rb-fsevent', '>= 0.4.0'
  gem 'infinity_test', '>= 1.0.2'
end

