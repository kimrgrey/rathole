class Comments::PostComment < Comments::Comment
  belongs_to :user, counter_cache: 'comments_count'
  belongs_to :post, counter_cache: 'comments_count'

  after_create :subscribe_user_on_post!
  after_create :fire_comment_created_event!

  validates :user, presence: true
  validates :post, presence: true

  def subscribe_user_on_post!
    user.subscribe_on_post!(post)
  end

  def fire_comment_created_event!
    event = Events::CommentCreatedEvent.new
    event.comment = self
    event.author = user
    event.post = post
    event.save!
  end
end