class ApplicationController < ActionController::Base
  protect_from_forgery :with => :exception

  before_filter :configure_permitted_parameters, :if => :devise_controller?

  protected

  def store_current_url_in_session
    store_location_for :user, request.url if !request.fullpath.match("/users") && !request.xhr?
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :user_name
  end

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || events_user_url
  end
end
