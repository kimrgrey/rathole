class Post < ActiveRecord::Base
  validates :title, presence: true

  belongs_to :user, counter_cache: true
  belongs_to :section, counter_cache: true

  delegate :user_name, to: :user, prefix: false

  def preview
    body.split("\r\n\r\n").first
  end
end