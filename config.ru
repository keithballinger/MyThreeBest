# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
require 'resque/server'
require 'resque/status_server'

Resque::Server.use Rack::Auth::Basic do |username, password|
  password == "m3b-staging"
end

run MyThreeBest::Application
#run Rack::URLMap.new \
#  "/"       => MyThreeBest::Application,
#  "/resque" => Resque::Server.new

