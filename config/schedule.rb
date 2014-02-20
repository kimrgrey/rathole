set :output, '/home/rathole/rathole/shared/log/whenever.log'

every 1.minute, roles: [:app] do
  rake "stickers:distribute"
end
