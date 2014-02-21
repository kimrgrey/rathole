set :output, '/home/rathole/rathole/shared/log/whenever.log'

every 1.day, at: '20:30 pm', roles: [:app] do
  rake 'stickers:distribute'
  rake 'rathole:collect_statistic'
  rake 'sitemap:refresh'
end
