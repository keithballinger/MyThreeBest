# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)

#run MyThreeBest::Application

require 'resque/server'

run Rack::URLMap.new \
  "/"       => MyThreeBest::Application,
  "/resque" => Resque::Server.new
