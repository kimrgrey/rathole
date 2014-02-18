every 1.day, at: '1:00 am', roles: [:app] do
  rake "stickers:distribute"
end
