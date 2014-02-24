class Events::UserCreatedEvent < Events::Event
  hstore :properties, :user

  after_create :deliver_event_to_admins

  def deliver_event_to_admins
    User.admins.each do |admin| 
      UserMailer.delay.notify_admin_about_registration(user, admin)
      admin.add_event(self)
    end
  end
end