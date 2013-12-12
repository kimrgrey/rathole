class Post < ActiveRecord::Base
  validates :title, presence: true

  belongs_to :user
  belongs_to :section

  delegate :user_name, to: :user, prefix: false
end