class Events::BugCreatedEvent < Events::Event
  hstore :properties, :bug
  hstore :properties, :post
  hstore :properties, :reporter, class_name: 'User'
  hstore :properties, :author, class_name: 'User'

  after_create :deliver_event_to_author

  def deliver_event_to_author
    PostMailer.delay.notify_author_about_bug(post, bug)
    author.add_event(self)
  end
end