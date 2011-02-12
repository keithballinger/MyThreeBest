require 'resque/job_with_status'

redis_config = YAML.load_file(File.join(Rails.root, 'config', 'redis.yml'))[Rails.env]
redis_url = ENV["REDISTOGO_URL"] || redis_config['redis_url']

uri = URI.parse(redis_url)
Store = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
Resque.redis = Store
Resque::Status.expire_in = (24 * 60 * 60)
