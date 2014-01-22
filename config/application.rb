require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env)

module Kgblogs
  class Application < Rails::Application
    config.i18n.default_locale = :ru
    config.after_initialize do
      ActionView::Base.sanitized_allowed_attributes += ['rel', 'target']
    end
  end
end
