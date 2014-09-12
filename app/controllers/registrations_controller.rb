class RegistrationsController < Devise::RegistrationsController
  rescue_from ActiveRecord::RecordNotUnique do |exception|
    flash[:error] = t('users.user_name_taken')
    render :new
  end
end