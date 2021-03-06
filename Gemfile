source :rubygems

#- Rails Stack
# gem 'rails', '3.1.0'
#gem 'rails', :git => 'git://github.com/guilleiguaran/rails.git', :branch => 'asset-digest-helper'
gem 'rails', :git => 'git://github.com/rails/rails.git', :branch => '3-1-stable'
gem 'haml-rails', '>= 0.3.4'
gem 'jquery-rails', '>= 0.2.7'
gem 'rake', '>= 0.9.2'
gem 'simple_form', '>= 1.3.1'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

#- Authentication
gem 'devise', '>= 1.3.0'
gem 'oa-core', '>= 0.2.1', :require => 'omniauth/core'
gem 'oa-oauth', '>= 0.2.1', :require => 'omniauth/oauth'

#- M3B Base
gem 'koala', '>= 1.0.0'
gem 'resque', '>= 1.15.0'
gem 'resque-status', '>= 0.2.2', :require => 'resque/status'
gem 'typhoeus', '>= 0.2.4'
gem 'yajl-ruby', '>= 0.8.2', :require => 'yajl/json_gem'
gem 'dalli', '>= 1.0.3'
gem 'hoptoad_notifier', '>= 2.4.9'
gem 'kaminari', '>= 0.10.4'

# - Scaling
gem 'resque-heroku-autoscaler', '>= 0.2.3'
gem 'heroku', '>= 2.2.8'

# - Only used in development
group :development do
  gem 'sqlite3', '>= 1.3.3'
  gem 'rails3-generators', '>= 0.17.4'
  gem 'annotate', '>= 2.4.0'
  gem 'foreman', '>= 0.18.0'
end


# - Only used in production
group :production, :staging do
  gem 'pg', '>= 0.10.1'
end


group :development, :test do
  gem 'rspec-rails', '>= 2.5.0'
  gem 'ruby-debug19', '>= 0.11.6', :require => 'ruby-debug'
end


#- For Testing
group :test do
  gem 'shoulda-matchers', '>= 1.0.0.beta1'
  gem 'factory_girl_rails', '>= 1.1.beta1', :require => false
  gem 'mocha', '>= 0.9.11'
  gem 'ffaker', '>= 1.2.0'
  gem 'simplecov', '>= 0.4.1', :require => false

  #- Acceptance tests
  gem 'capybara', '>= 1.0.0'
  gem 'capybara-webkit', '>= 0.6.1'
  gem 'launchy', '>= 0.3.7'
  gem 'database_cleaner', '>= 0.6.6'

  #- Code metrics

  #- Speed up our tests
  gem 'spork', '>= 0.9.0.rc4'
  gem 'guard-spork', '>= 0.1.6'
  gem 'rb-fsevent', '>= 0.4.0'
  gem 'infinity_test', '>= 1.0.2'
end

