class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, 
         :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable

  include Authority::UserAbilities
  include Authority::Abilities

  self.authorizer = UserAuthorizer

  validates :user_name, uniqueness: true, format: {with: /\A[a-zA-Z0-9_-]{3,100}$\Z/}

  has_many :posts
  has_many :sections
  has_many :comments
  has_many :imports
  has_many :pictures

  mount_uploader :avatar, AvatarUploader

  after_create :create_default_section

  def last_posts(count = 5) 
    posts.published_only.order('posts.created_at DESC').limit(count)
  end

  private

  def create_default_section
    section = sections.build(name: I18n.t('sections.default_name'))
    section.save!
  end
end
