Devise.setup do |config|
  config.secret_key = Rails.application.secrets.devise_key
  config.mailer_sender = Rails.application.secrets.mail_from

  require 'devise/orm/active_record'

  config.case_insensitive_keys = [ :email ]
  config.strip_whitespace_keys = [ :email ]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 10
  config.reconfirmable = true
  config.password_length = 8..128
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
  config.timeout_in = 1.day

  config.omniauth :facebook, Rails.application.secrets.fb_app_id, Rails.application.secrets.fb_secret, { :scope => 'email' }
  config.omniauth :vkontakte, Rails.application.secrets.vk_app_id, Rails.application.secrets.vk_secret, { :scope => 'email' }
  config.omniauth :github, Rails.application.secrets.gh_app_id, Rails.application.secrets.gh_secret, { :scope => 'user' }
end
