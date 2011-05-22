require 'resque/job_with_status'
require 'resque/failure/multiple'
require 'resque/failure/hoptoad'
require 'resque/failure/redis'
require 'resque/server'
require 'resque/status_server'

Resque::Server.use Rack::Auth::Basic do |username, password|
  password == "m3b-staging"
end

redis_config = YAML.load_file(File.join(Rails.root, 'config', 'redis.yml'))[Rails.env]
redis_url = ENV["REDISTOGO_URL"] || redis_config['redis_url']

uri = URI.parse(redis_url)
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
Resque::Status.expire_in = (24 * 60 * 60)


# Failure notifications
#Resque::Failure::Hoptoad.configure do |config|
#  config.api_key = config.api_key = ENV['HOPTOAD_API_KEY']
#  config.secure = true
#end
#Resque::Failure::Multiple.classes = [Resque::Failure::Redis, Resque::Failure::Hoptoad]
#Resque::Failure.backend = Resque::Failure::Multiple
