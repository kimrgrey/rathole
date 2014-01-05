class Post < ActiveRecord::Base
  include Authority::Abilities
  
  self.authorizer = PostAuthorizer

  validates :title, presence: true
  validates :section, presence: true

  belongs_to :user, counter_cache: true
  belongs_to :section, counter_cache: true

  has_many :comments

  delegate :user_name, to: :user, prefix: false
  delegate :avatar_url, to: :user, prefix: true

  enum state: [ :draft, :published ]
  
  scope :in_order, -> { order('posts.created_at DESC') }
  scope :tagged_with, -> (tag) { where('posts.tags @> ARRAY[?]', tag) }
  scope :draft_only, -> { where('posts.state = ?', STATE[:draft]) }
  scope :published_only, -> { where('posts.state = ?', STATE[:published]) }

  def preview(lines = 2)
    body.split("\r\n\r\n").first(lines).join("\r\n\r\n")
  end

  def toggle
    if self.draft?
      self.state = :published
    else
      self.state = :draft
    end
    self.save
  end

  def tag_list
    tags.join(',')
  end

  def tag_list=(tag_list)
    self.tags = tag_list.split(',')
  end
end