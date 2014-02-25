host = '127.0.0.1'
port = 6379
namespace = 'rathole'
url = "redis://#{host}:#{port}/#{namespace}"

$redis = Redis.new(:url => url, :driver => :hiredis)