Kgblogs::Application.configure do
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.serve_static_assets = false
  config.assets.js_compressor = :uglifier
  config.assets.compile = false
  config.assets.digest = true
  config.assets.version = '1.0'
  config.log_level = :info
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.log_formatter = ::Logger::Formatter.new
  config.action_mailer.default_url_options = { :host => 'rathole.io' }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :address              => "smtp.yandex.ru",
    :port                 => 587,
    :user_name            => 'noreply@kimrgrey.org',
    :password             => 'o#m0fzaiF6',
    :authentication       => 'plain'
  }
  config.action_mailer.raise_delivery_errors = true
end
