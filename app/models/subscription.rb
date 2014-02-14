class Subscription < ActiveRecord::Base
  belongs_to :subscriber, class_name: 'User', foreign_key: 'subscriber_id'
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post

  validates :subscriber, presence: true

  delegate :title, to: :post, prefix: true
end