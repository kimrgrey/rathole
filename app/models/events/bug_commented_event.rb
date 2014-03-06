class Events::BugCommentedEvent < Events::Event
  hstore :properties, :comment, class_name: 'Comments::BugComment'
  hstore :properties, :bug

  after_create :deliver_event_to_user

  def user
    comment.author?(bug.reporter) ? bug.author : bug.reporter
  end

  def author
    comment.user
  end

  def deliver_event_to_user
    BugMailer.delay.notify_user_about_comment_in_bug(user, bug, comment) 
    user.add_event(self)
  end
end