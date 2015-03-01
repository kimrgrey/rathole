class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, 
         :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable, :omniauthable

  validates :user_name, :uniqueness => true, :format => {with: /\A[a-zA-Z0-9_-]{2,100}$\Z/}, :user_name => true

  has_many :posts
  has_many :sections, :dependent => :destroy
  has_many :comments, :class_name => 'Comments::PostComment'
  has_many :imports
  has_many :pictures
  has_many :subscriptions, :foreign_key => 'subscriber_id'
  has_many :invites
  has_many :bugs, :foreign_key => 'reporter_id'
  has_many :identities, :inverse_of => :user

  has_and_belongs_to_many :stickers

  scope :with_role, -> (role_name) { where("users.roles @> ARRAY[?]", role_name) }
  scope :admins, -> { with_role(:admin) }
  scope :in_order, -> { order('users.posts_count DESC, users.comments_count DESC') }
  scope :in_featured_order, -> { order('users.last_published_at DESC NULLS LAST') }
  scope :featured, -> (count = 4) { in_order.limit(count) }
  scope :recently_updated, -> (from, to) { where('users.updated_at >= :from AND users.updated_at < :to', :from => from, :to => to) }

  before_save :set_default_avatar, :on => :create

  after_create :create_default_section
  after_create :fire_user_created_event!

  include Redcarpeted

  redcarpet :about

  def self.new_with_session(params, session)
    super.tap do |user|
      auth = session.delete('devise.omniauth')
      if auth.present?
        user.user_name = user_name = [auth.info.nickname, auth.extra.raw_info.screen_name, auth.info.email.gsub('.','_').split('@').first].find(&:present?)
        user.email = auth.info.email
        user.valid?
      end
    end
  end

  def self.find_or_create_by_auth(auth, current_user = nil)
    identity = Identity.find_by_auth(auth)
    user = User.initialize_from_auth(auth, current_user)
    if identity.blank? || (user.persisted? && identity.user != user)
      identity = user.identities.build(:uuid => auth.uid, :provider => auth.provider)
      user.persisted? ? identity.save : user.save
    end
    identity.user
  end

  def self.initialize_from_auth(auth, user = nil)
    if user.blank?
      email = auth.info.email
      user_name = [auth.info.nickname, auth.extra.raw_info.screen_name, email.gsub('.','_').split('@').first].find(&:present?)
      user = User.new(:user_name => user_name, :email => email)
    end
    user
  end

  def avatar_path
    self.attributes['avatar_path'] || 'thumb_avatar_default.png'
  end

  def set_default_avatar
    self.avatar_path = 'thumb_avatar_default.png' if avatar_path.blank?
  end

  def assign_sticker!(sticker)
    unless stickers.include?(sticker) 
      stickers << sticker 
      save!
    end
  end

  def remove_sticker!(sticker)
    if stickers.include?(sticker)
      stickers.delete(sticker) 
      save!
    end
  end

  def last_posts(count = 5) 
    posts.published_only.order('posts.published_at DESC').limit(count)
  end

  def last_post
    posts.published_only.order('posts.published_at DESC').first
  end

  def has_role?(role_name)
    roles.include?(role_name.to_s)
  end

  def has_publications?
    posts.published_only.any?
  end

  def admin?
    has_role?(:admin)
  end

  def grant(role_names)
    write_attribute(:roles, Array(role_names).map(&:to_s)) 
  end

  def subscribe_on_post(post)
    subscriptions.find_or_create_by(:post_id => post.id)
  end

  def unsubscribe_from_post(post)
    subscription = subscriptions.find_by(:post_id => post.id)
    subscription.destroy if subscription.present?
  end

  def subscribe_on_post!(post)
    subscriptions.find_or_create_by!(:post_id => post.id)
  end

  def subscribe_on_author(author)
    subscriptions.find_or_create_by(:author_id => author.id)
  end

  def unsubscribe_from_author(author)
    subscription = subscriptions.find_by(:author_id => author.id)
    subscription.destroy if subscription.present?
  end

  def subscribe_from_author!(author)
    subscriptions.find_or_create_by!(:author_id => author.id)
  end

  def subscribed_on?(user_or_post)
    if user_or_post.is_a?(User)
      subscribed_on_user?(user_or_post)
    elsif user_or_post.is_a?(Post)
      subscribed_on_post?(user_or_post)
    else
      false
    end
  end

  def subscribed_on_user?(user)
    subscriptions.find_by(:author_id => user.id).present?
  end

  def subscribed_on_post?(post)
    subscriptions.find_by(:post_id => post.id).present?
  end

  def subscribers
    Subscription.where(:author_id => self.id).map(&:subscriber)
  end

  def redis_events_key
    "users:#{id}:events"
  end

  def add_event(event)
    $redis.zadd(redis_events_key, event.updated_at.to_i, event.id)
  end

  def events(from, to)
    Events::Event.where id: $redis.zrangebyscore(redis_events_key, from.to_i, to.to_i)
  end

  def is_author_of?(post_or_comment)
    if post_or_comment.is_a?(Post)
      is_author_of_post?(post_or_comment)
    elsif post_or_comment.is_a?(Comment)
      is_author_of_comment?(post_or_comment)
    else
      false
    end
  end

  def is_author_of_post?(post)
    post.user == self
  end

  def is_author_of_comment?(comment)
    comment.user == comment
  end

  protected

  def email_required?
    if identities.empty?
      super
    end
  end

  def password_required?
    if identities.empty?
      super
    end
  end

  private

  def create_default_section
    section = sections.build(name: I18n.t('sections.default_name'))
    section.save!
  end

  def fire_user_created_event!
    event = Events::UserCreatedEvent.new
    event.user = self
    event.save!
  end
end
