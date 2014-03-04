class Events::BugRejectedEvent < Events::Event
  hstore :properties, :bug
  hstore :properties, :post
  hstore :properties, :reporter, class_name: 'User'
  hstore :properties, :author, class_name: 'User'

  after_create :deliver_event_to_reporter

  def deliver_event_to_reporter
    BugMailer.delay.notify_reporter_about_rejected_bug(bug)
    reporter.add_event(self)
  end
end