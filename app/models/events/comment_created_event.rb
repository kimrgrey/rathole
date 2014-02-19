class Events::CommentCreatedEvent < Events::Event
  hstore :properties, :comment, 'Comment'
  hstore :properties, :author, 'User'
  hstore :properties, :post, 'Post'

  after_create :send_mails_to_subscribers

  def send_mails_to_subscribers
    post.subscriptions.each do |subscription|
      PostMailer.notify_subscriber_about_comment(subscription.subscriber, comment).deliver
    end
  end
end