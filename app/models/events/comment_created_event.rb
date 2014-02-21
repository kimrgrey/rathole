class Events::CommentCreatedEvent < Events::Event
  hstore :properties, :comment
  hstore :properties, :author, class_name: 'User'
  hstore :properties, :post

  after_create :send_mails_to_subscribers

  def send_mails_to_subscribers
    post.subscriptions.each do |subscription|
      PostMailer.delay.notify_subscriber_about_comment(subscription.subscriber, comment)
    end
  end
end