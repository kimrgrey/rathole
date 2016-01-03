RSpec.configure do |config|
  config.before(:each) do
    Rathole.redis.flushdb
  end
end
