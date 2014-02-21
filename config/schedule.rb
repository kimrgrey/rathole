set :output, '/home/rathole/rathole/shared/log/whenever.log'

every 1.day, at: '0:30 am', roles: [:app] do
  rake 'stickers:distribute'
  rake 'rathole:collect_statistic'
  rake 'sitemap:refresh'
end
