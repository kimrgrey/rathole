class Comment < ActiveRecord::Base
  paginates_per 50

  include Authority::Abilities
  include Redcarpeted
  
  redcarpet :body

  validates :body, presence: true

  belongs_to :user, counter_cache: true
  belongs_to :post, counter_cache: true

  scope :in_order, ->{ order('comments.created_at ASC') }

  delegate :user_name, to: :user, prefix: false
  delegate :avatar_url, to: :user, prefix: true

  after_create :subscribe_user_on_post!
  after_create :fire_comment_created_event!

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