source 'http://rubygems.org'

#- Basic Rails App
gem 'rails', '>= 3.0.4'
gem 'rails3-generators', '>= 0.17.4'
gem 'haml-rails', '>= 0.3.4'
gem 'jquery-rails', '>= 0.2.7'
gem 'annotate', '>= 2.4.0'


#- Authentication
gem 'devise', '>= 1.2.rc'
gem 'omniauth', '>= 0.2.0.beta3'


#- M3B Base
gem 'koala', '>= 1.0.0.beta'
gem 'resque', '>= 1.13.0'
gem 'toystore', '>= 0.6.3'
gem 'adapter-redis', '>= 0.5.1', :require => 'adapter/redis'
gem 'typhoeus', '>= 0.2.1'
gem 'yajl-ruby', '>= 0.8.1'
gem 'dalli', '>= 1.0.2'

# - Only used in development
group :development do
  gem 'sqlite3-ruby', '>= 1.3.3', :require => 'sqlite3'
end


# - Only used in production
group :production, :staging do
  gem 'pg', '>= 0.10.1'
end


# - Testing libraries with generators and rake tasks
group :development, :test do
  gem 'rspec-rails', '>= 2.5.0'
  gem 'steak', '>= 1.1.0'
  gem 'thin' # To Run development server and integration tests faster
end


#- For Testing
group :test do
  gem 'factory_girl_rails', '>= 1.1.beta1'
  gem 'shoulda-matchers', '>= 1.0.0.beta1'
  gem 'mocha', '>= 0.9.11'
  gem 'ffaker', '>= 1.2.0'
  gem 'cover_me', '>= 1.0.0.rc5'
  gem 'fakeweb', '>= 1.3.0'
  gem 'capybara', '>= 0.4.1.2'
  gem 'resque_spec', '>= 0.4.2'
end


