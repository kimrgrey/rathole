class Events::UserCreatedEvent < Events::Event
  hstore :properties, :user

  after_create :send_mails_to_admins

  def send_mails_to_admins
    User.admins.each do |admin| 
      UserMailer.delay.notify_admin_about_registration(user, admin)
    end
  end
end