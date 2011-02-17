require 'resque/job_with_status'

redis_config = YAML.load_file(File.join(Rails.root, 'config', 'redis.yml'))[Rails.env]
redis_url = ENV["REDISTOGO_URL"] || redis_config['redis_url']

uri = URI.parse(redis_url)
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
Resque::Status.expire_in = (24 * 60 * 60)
