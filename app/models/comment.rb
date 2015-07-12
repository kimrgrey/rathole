class Comment < ActiveRecord::Base
  paginates_per 50

  include Redcarpeted

  belongs_to :user, :counter_cache => 'comments_count'
  belongs_to :parent, :polymorphic => true, :counter_cache => 'comments_count', :touch => true

  redcarpet :body

  validates :body, :presence => true
  validates :user, :presence => true
  validates :parent, :presence => true

  scope :in_order, ->{ order('comments.created_at DESC') }
  scope :recently_updated, -> (from, to) { where('comments.updated_at >= :from AND comments.updated_at < :to', from: from, to: to) }

  delegate :user_name, to: :user, prefix: false
  delegate :avatar_path, to: :user, prefix: true

  acts_as_paranoid

  after_create :subscribe_user_on_post!, :if => proc { |s| s.parent_type == "Post" }
  after_create :fire_comment_created_event!, :if => proc { |s| s.parent_type == "Post" }
  after_create :fire_bug_commented_event!, :if => proc { |s| s.parent_type == "Bug" }

  after_restore :touch_self

  def author?(u)
    self.user == u
  end

  def to_sync_json(lsd, next_lsd)
    json = {
      :id => id,
      :user_id => user_id,
      :created_at => created_at.to_i,
      :updated_at => updated_at.to_i
    }
    json[:body] = body_html if body_updated_at >= lsd
    json[:deleted_at] = deleted_at.to_i if deleted?
    json
  end

  private

  def fire_bug_commented_event!
    event = Events::BugCommentedEvent.new
    event.bug = parent
    event.comment = self
    event.save!
  end

  def subscribe_user_on_post!
    user.subscribe_on_post!(parent)
  end

  def fire_comment_created_event!
    event = Events::CommentCreatedEvent.new
    event.comment = self
    event.author = user
    event.post = parent
    event.save!
  end

  def touch_self
    time = Time.now
    update(updated_at: time, body_updated_at: time)
  end
end
