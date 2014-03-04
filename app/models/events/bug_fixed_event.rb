class Events::BugFixedEvent < Events::Event
  hstore :properties, :bug
  hstore :properties, :post
  hstore :properties, :reporter, class_name: 'User'
  hstore :properties, :author, class_name: 'User'

  after_create :deliver_event_to_reporter

  def deliver_event_to_reporter
    reporter.add_event(self)
  end
end