Devise.setup do |config|
  config.secret_key = '31dbf1a7a746705da0d117fe6bd3bf5c2a265d1d306ff5f76f0c4e6b5f81bfc73667ae9cc7856928694eca5527522e58a4ee1948a8b4a2bc702a4629122de4cc'
  config.mailer_sender = 'noreply@kimrgrey.org'

  require 'devise/orm/active_record'

  config.case_insensitive_keys = [ :email ]
  config.strip_whitespace_keys = [ :email ]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 10
  config.reconfirmable = true
  config.password_length = 8..128
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
end
