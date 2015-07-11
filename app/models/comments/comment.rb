class Comments::Comment < ActiveRecord::Base
  paginates_per 50

  include Redcarpeted

  redcarpet :body

  validates :body, presence: true

  scope :in_order, ->{ order('comments.created_at DESC') }
  scope :recently_updated, -> (from, to) { where('comments.updated_at >= :from AND comments.updated_at < :to', from: from, to: to) }

  delegate :user_name, to: :user, prefix: false
  delegate :avatar_path, to: :user, prefix: true

  acts_as_paranoid

  after_restore :touch_self

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

  def touch_self
    time = Time.now
    update(updated_at: time, body_updated_at: time)
  end
end
