class Comment < ActiveRecord::Base
  validates :body, presence: true

  belongs_to :user
  belongs_to :post

  scope :in_order, -> { order('comments.created_at DESC') }

  delegate :user_name, to: :user, prefix: false
end