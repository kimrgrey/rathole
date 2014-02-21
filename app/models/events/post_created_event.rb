class Events::PostCreatedEvent < Events::Event
  hstore :properties, :post
  hstore :properties, :author, class_name: 'User'

  after_create :send_mail_to_admins
  after_create :send_mails_to_subscribers
  
  def send_mail_to_admins
    User.admins.each do |admin| 
      PostMailer.delay.notify_admin_about_post(post, admin) if admin != author
    end
  end

  def send_mails_to_subscribers
    author.subscribers.each do |subscriber|
      PostMailer.delay.notify_subscriber_about_post(post, subscriber) unless subscriber.admin?
    end
  end
end