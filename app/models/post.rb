class Post < ActiveRecord::Base
  DEFAULT_PREVIEW_SIZE = 750
  SHORT_PREVIEW_SIZE   = 550
  LONG_PREVIEW_SIZE    = 750
  READ_MORE = "..."

  include Authority::Abilities
  
  self.authorizer = PostAuthorizer

  validates :title, presence: true
  validates :body, presence: true
  validates :section, presence: true
  validates :user, presence: true

  belongs_to :user, counter_cache: true
  belongs_to :section, counter_cache: true

  has_many :comments
  has_many :pictures

  delegate :user_name, to: :user, prefix: false
  delegate :avatar_url, to: :user, prefix: true
  delegate :name, to: :section, prefix: true

  enum state: [ :draft, :published ]
  
  scope :in_order, -> { order('posts.created_at DESC') }
  scope :draft_only, -> { where('posts.state = ?', STATE[:draft]) }
  scope :published_only, -> { where('posts.state = ?', STATE[:published]) }
  scope :visible_on_main, -> { where('posts.visible_on_main = ?', true) }

  before_validation :extract_preview_from_body!

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

  def toggle
    if self.draft?
      self.state = :published
    else
      self.state = :draft
    end
    self.save
  end

  def extract_preview_from_body!(force = false)
    if force || body_changed?
      self.preview = extract_preview(Post::DEFAULT_PREVIEW_SIZE)
    end
  end
end