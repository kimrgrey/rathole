class Post < ActiveRecord::Base
  validates :title, presence: true

  belongs_to :user, counter_cache: true
  belongs_to :section, counter_cache: true

  delegate :user_name, to: :user, prefix: false

  def preview(lines = 2)
    body.split("\r\n\r\n").first(lines).join("\r\n\r\n")
  end
end