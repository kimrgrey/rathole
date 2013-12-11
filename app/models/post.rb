class Post < ActiveRecord::Base
  validates :title, presence: true

  belongs_to :user

  delegate :user_name, to: :user, prefix: false
end