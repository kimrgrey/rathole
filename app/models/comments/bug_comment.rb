class Comments::BugComment < Comments::Comment
  belongs_to :user
  belongs_to :bug

  validates :user, presence: true
  validates :bug, presence: true

  after_create :fire_bug_commented_event!

  def author?(u)
    self.user == u
  end

  private

  def fire_bug_commented_event!
    event = Events::BugCommentedEvent.new
    event.bug = bug
    event.comment = self
    event.save!
  end
end