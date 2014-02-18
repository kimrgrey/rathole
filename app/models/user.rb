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
  has_many :subscriptions, foreign_key: 'subscriber_id'

  has_and_belongs_to_many :stickers

  scope :with_role, -> (role_name) { where("users.roles @> ARRAY[?]", role_name) }
  scope :admins, -> { with_role(:admin) }

  mount_uploader :avatar, AvatarUploader

  after_create :create_default_section

  include Redcarpeted

  redcarpet :about

  def assign_sticker!(sticker)
    stickers << sticker unless stickers.include?(sticker) 
    save!
  end

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

  def subscribe_on_post(post)
    subscriptions.find_or_create_by(post_id: post.id)
  end

  def subscribe_on_post!(post)
    subscriptions.find_or_create_by!(post_id: post.id)
  end

  def subscribe_on_author(author)
    subscriptions.find_or_create_by(author_id: author.id)
  end

  def unsubscribe_on_author(author)
    subscription = subscriptions.find_by(author_id: author.id)
    subscription.destroy if subscription.present?
  end

  def subscribe_on_author!(author)
    subscriptions.find_or_create_by!(author_id: author.id)
  end

  def subscribed_on?(user_or_post)
    if user_or_post.is_a?(User)
      subscribed_on_user?(user_or_post)
    elsif user_or_post.is_a?(User)
      subscribed_on_post?(user_or_post)
    else
      false
    end
  end

  def subscribed_on_user?(user)
    subscriptions.find_by(author_id: user.id).present?
  end

  def subscribed_on_post?(post)
    subscriptions.find_by(post_id: post.id).present?
  end

  def subscribers
    Subscription.where(author_id: self.id).map(&:subscriber)
  end

  private

  def create_default_section
    section = sections.build(name: I18n.t('sections.default_name'))
    section.save!
  end
end
