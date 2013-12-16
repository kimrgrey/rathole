class Section < ActiveRecord::Base
  validates :name, presence: true

  belongs_to :user
  
  has_many :posts

  scope :in_order, -> { order('sections.name') }

  delegate :user_name, to: :user, prefix: false
end