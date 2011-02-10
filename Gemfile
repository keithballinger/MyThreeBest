source 'http://rubygems.org'

#- Basic Rails App
gem 'rails', '3.0.4'
gem 'rails3-generators', '>= 0.17.4'
gem 'haml-rails', '>= 0.3.4'
gem 'jquery-rails', '>= 0.2.7'


#- Authentication
gem 'devise', '>= 1.1.5'
gem 'omniauth', '>= 0.1.6'

# - Only used in development
group :development do
  gem 'sqlite3-ruby', :require => 'sqlite3'
end


# - Only used in production
group :production, :staging do
  gem 'pg', '0.10.1'
end


# - Testing libraries with generators and rake tasks
group :development, :test do
  gem 'rspec-rails', '>= 2.5.0'
  gem 'thin' # To Run development server and integration tests faster
end


#- For Testing
group :test do
  gem 'factory_girl_rails', '1.1.beta1'
  gem 'shoulda-matchers', '1.0.0.beta1'
  gem 'mocha', '>= 0.9.11'
  gem 'cover_me', '>= 1.0.0.rc5'
  gem 'fakeweb', '>= 1.3.0'
end


