class Comment < ActiveRecord::Base
  validates :body, presence: true

  belongs_to :user, counter_cache: true
  belongs_to :post, counter_cache: true

  scope :in_order, -> { order('comments.created_at ASC') }

  delegate :user_name, to: :user, prefix: false
end