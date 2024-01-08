REDIS_SERVER = "127.0.0.1"
REDIS_PORT = '6379'
Sidekiq.configure_client do |config|
   config.redis = { url: "redis://#{REDIS_SERVER}:#{REDIS_PORT}/12" }
end
Sidekiq.configure_server do |config|
   config.redis = { url: "redis://#{REDIS_SERVER}:#{REDIS_PORT}/12" }
end

REDIS = Redis.new(url: "redis://#{REDIS_SERVER}:#{REDIS_PORT}")
