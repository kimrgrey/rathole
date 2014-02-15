require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env)

module Rathole
  class Application < Rails::Application
    config.i18n.default_locale = :ru
    config.time_zone = 'Moscow'
    config.after_initialize do
      ActionView::Base.sanitized_allowed_attributes += ['rel', 'target']
    end
    config.autoload_paths << "#{config.root}/app/validators"
  end
end
