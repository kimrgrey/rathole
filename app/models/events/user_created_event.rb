class Events::UserCreatedEvent < Events::Event
  hstore :properties, :user, 'User'

  after_create :send_mails_to_admins

  def send_mails_to_admins
    User.admins.each do |admin| 
      UserMailer.notify_admin_about_registration(user, admin).deliver
    end
  end
end