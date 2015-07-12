class Events::CommentCreatedEvent < Events::Event
  hstore :properties, :comment, class_name: 'Comment'
  hstore :properties, :author, class_name: 'User'
  hstore :properties, :post

  after_create :deliver_event_to_subscribers

  def deliver_event_to_subscribers
    post.subscriptions.each do |subscription|
      subscriber = subscription.subscriber
      if subscriber != author
        PostMailer.delay.notify_subscriber_about_comment(subscriber, comment)
        subscriber.add_event(self)
      end
    end
  end

  def export_to_redis
    post.subscriptions.each { |subscription| subscription.subscriber.add_event(self) if subscription.subscriber != author }
  end
end
