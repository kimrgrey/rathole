class Sync < ActiveRecord::Base
  serialize :result, Hash

  validates :lsd, :presence => true
  validates :next_lsd, :presence => true
  validates :token, :presence => true

  belongs_to :post

  before_validation :generate_token, :on => :create

  after_commit :perform!, :on => :create

  def post_sync?
    post_id.present?
  end

  def perform!
    return if finished
    json = {
      :lsd => lsd.to_i,
      :next_lsd => next_lsd.to_i,
    }
    if post.blank?
      json[:users] = User.recently_updated(lsd, next_lsd)
                      .in_order
                      .map { |u| u.to_sync_json(lsd, next_lsd) }

      json[:posts] = Post.with_deleted
                      .published_and_hidden
                      .recently_updated(lsd, next_lsd)
                      .in_order
                      .map { |p| p.to_sync_json(lsd, next_lsd) }
    else
      json[:users] = User.recently_updated(lsd, next_lsd)
                      .where(:id => [post.user_id] + post.comments.map(&:user_id))
                      .in_order
                      .map { |u| u.to_sync_json(lsd, next_lsd) }

      json[:post] = post.to_sync_json(lsd, next_lsd)
    end
    self.result = json
    self.finished = true
    self.save
  end

  handle_asynchronously :perform!

  def attempt!
    self.attempts_count += 1
    generate_token
    save
  end

  private

  def generate_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless Sync.exists?(:token => random_token)
    end
  end
end
