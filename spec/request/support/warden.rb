RSpec.configure do |config|
  config.include Warden::Test::Helpers, :type => :request
  config.after(:each, :type => :request) { Warden.test_reset! }
end
