require 'resque/job_with_status'
require 'resque/failure/multiple'
require 'resque/failure/hoptoad'
require 'resque/failure/redis'
require 'resque/server'
require 'resque/status_server'
require 'resque/plugins/resque_heroku_autoscaler'


# Basic Resque Configuration
redis_config = YAML.load_file(File.join(Rails.root, 'config', 'redis.yml'))[Rails.env]
redis_url = ENV["REDISTOGO_URL"] || redis_config['redis_url']

uri = URI.parse(redis_url)
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
Resque::Status.expire_in = (24 * 60 * 60)


# Resque server configuration
Resque::Server.use Rack::Auth::Basic do |username, password|
  password == "m3b-staging"
end


# Auto Scaling configuration
Resque::Plugins::HerokuAutoscaler.config do |c|
  if Rails.env.production? || Rails.env.staging?
    c.heroku_user = ENV['HEROKU_USER']
    c.heroku_pass = ENV['HEROKU_PASSWORD']
    c.heroku_app  = ENV['HEROKU_APP']
    c.new_worker_count do |pending|
      (pending/1).ceil.to_i
    end
    c.wait_time = 10
  else
    c.scaling_disabled = true
  end
end


# Resque Failure notifications
Resque::Failure::Hoptoad.configure do |config|
  config.api_key = config.api_key = ENV['HOPTOAD_API_KEY']
  config.secure = true
end
Resque::Failure::Multiple.classes = [Resque::Failure::Redis, Resque::Failure::Hoptoad]
Resque::Failure.backend = Resque::Failure::Multiple
