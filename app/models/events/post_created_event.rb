class Events::PostCreatedEvent < Events::Event
  hstore :properties, :post
  hstore :properties, :author, class_name: 'User'

  after_create :update_last_published_at
  after_create :deliver_event_to_admins
  after_create :deliver_event_to_subscribers

  def update_last_published_at
    author.update last_published_at: post.published_at
  end
  
  def deliver_event_to_admins
    User.admins.each do |admin| 
      if admin != author
        PostMailer.delay.notify_admin_about_post(post, admin)
        admin.add_event(self)
      end
    end
  end

  def deliver_event_to_subscribers
    author.subscribers.each do |subscriber|
      unless subscriber.admin?
        PostMailer.delay.notify_subscriber_about_post(post, subscriber)
        subscriber.add_event(self)
      end
    end
  end

  def export_to_redis
    User.admins.each { |admin| admin.add_event(self) if admin != author }
    author.subscribers.each { |subscriber| subscriber.add_event(self) unless subscriber.admin? }
  end
end