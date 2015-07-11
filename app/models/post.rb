class Post < ActiveRecord::Base
  paginates_per 25

  DEFAULT_PREVIEW_SIZE = 750
  SHORT_PREVIEW_SIZE   = 550
  LONG_PREVIEW_SIZE    = 750
  READ_MORE = "..."

  validates :title, presence: true
  validates :body, presence: true
  validates :section, presence: true
  validates :user, presence: true

  belongs_to :user, counter_cache: true
  belongs_to :section, counter_cache: true

  has_many :comments, class_name: 'Comments::PostComment', dependent: :destroy
  has_many :pictures
  has_many :subscriptions, dependent: :destroy
  has_many :bugs
  has_many :claims, inverse_of: :post, dependent: :destroy

  delegate :user_name, to: :user, prefix: false
  delegate :avatar_path, to: :user, prefix: true
  delegate :name, to: :section, prefix: true
  delegate :email, to: :user, prefix: true

  enum state: [ :draft, :published, :hidden ]

  scope :in_order, -> { order('posts.published_at DESC') }
  scope :draft_only, -> { where('posts.state = ?', Post.states[:draft]) }
  scope :published_only, -> { where('posts.state = ?', Post.states[:published]) }
  scope :published_and_hidden, -> { where('posts.state IN (?)', [Post.states[:published], Post.states[:hidden]]) }
  scope :visible_on_main, -> { published_only.where('posts.visible_on_main = ?', true) }
  scope :my_or_published, -> (user) { where('posts.user_id = ? OR posts.state = ?', user.id, Post.states[:published]) }
  scope :recently_updated, -> (from, to) { where('posts.updated_at >= :from AND posts.updated_at < :to', from: from, to: to) }

  before_validation :extract_preview_from_body!

  after_create :subscribe_author!

  acts_as_paranoid

  after_restore :restore_comments
  after_restore :touch_self

  include Redcarpeted

  redcarpet :body
  redcarpet :preview

  include Taggable

  def extract_preview(size = Post::DEFAULT_PREVIEW_SIZE)
    if size.is_a?(Symbol)
      size = case size
        when :short then Post::SHORT_PREVIEW_SIZE
        when :long then Post::LONG_PREVIEW_SIZE
        else Post::DEFAULT_PREVIEW_SIZE
      end
    end
    result = body[0...size]
    result << Post::READ_MORE if size < body.size
    result
  end

  def has_bugs?
    bugs.open_only.any?
  end

  def toggle
    if draft?
      self.state = :published
      self.published_at = Time.now
      saved = save
      fire_post_created_event! if saved
      saved
    elsif published?
      self.state = :hidden
      save
    elsif hidden?
      self.state = :published
      save
    end
  end

  def show_on_main
    update(visible_on_main: true)
  end

  def hide_from_main
    update(visible_on_main: false)
  end

  def extract_preview_from_body!(force = false)
    if force || body_changed?
      self.preview = extract_preview(Post::DEFAULT_PREVIEW_SIZE)
    end
  end

  def subscribe!(user)
    subscriptions.find_or_create_by!(subscriber_id: user.id)
  end

  def subscribe(user)
    subscriptions.find_or_initialize_by(subscriber_id: user.id)
  end

  def subscribe_author!
    subscribe!(user)
  end

  def subscribe_author
    subscribe(user)
  end

  def subscribe_commentators!
    comments.each do |comment|
      subscribe!(comment.user)
    end
  end

  def fire_post_created_event!
    if published?
      event = Events::PostCreatedEvent.new
      event.post = self
      event.author = self.user
      event.save!
    end
  end

  private

  def restore_comments
    comments.with_deleted.each { |c| c.restore }
  end

  def touch_self
    time = Time.now
    update(updated_at: time, body_updated_at: time, preview_updated_at: time)
  end
end
