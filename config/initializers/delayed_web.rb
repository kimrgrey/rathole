Rails.application.config.to_prepare do
  Delayed::Web::Job.backend = 'active_record'
end
