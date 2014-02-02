class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, 
         :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable

  include Authority::UserAbilities
  include Authority::Abilities

  self.authorizer = UserAuthorizer

  validates :user_name, uniqueness: true, format: {with: /\A[a-zA-Z0-9_-]{3,100}$\Z/}, user_name: true

  has_many :posts
  has_many :sections
  has_many :comments
  has_many :imports
  has_many :pictures

  has_and_belongs_to_many :stickers

  scope :with_role, -> (role_name) { where("users.roles @> ARRAY[?]", role_name) }

  mount_uploader :avatar, AvatarUploader

  after_create :create_default_section

  include Redcarpeted

  redcarpet :about


  def last_posts(count = 5) 
    posts.published_only.order('posts.created_at DESC').limit(count)
  end

  def has_role?(role_name)
    roles.include?(role_name.to_s)
  end

  def admin?
    has_role?(:admin)
  end

  def grant(role_names)
    write_attribute(:roles, Array(role_names).map(&:to_s)) 
  end

  private

  def create_default_section
    section = sections.build(name: I18n.t('sections.default_name'))
    section.save!
  end
end
