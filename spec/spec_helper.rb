require 'simplecov'
SimpleCov.start 'rails'

require 'spork'

ENV["RAILS_ENV"] = 'test'

Spork.prefork do

  require "rails/application"
  Spork.trap_method(Rails::Application, :reload_routes!)

  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'

  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.mock_with :mocha
    config.use_transactional_fixtures = true
    config.include Devise::TestHelpers, :type => :controller
    config.include KoalaHelpers
  end

end

Spork.each_run do
  require 'factory_girl_rails'
end

