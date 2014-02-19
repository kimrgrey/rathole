class UserMailer < ActionMailer::Base
  add_template_helper(RoutesHelper)
  
  default from: Rails.application.secrets.mail_from

  def notify_admin_about_registration(user, admin)
    @user = user
    @admin = admin
    mail(to: @admin.email, subject: I18n.t('user_mailer.notify_admin_about_registration.subject'))
  end
end
