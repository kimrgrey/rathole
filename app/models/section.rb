class Section < ActiveRecord::Base
  include Authority::Abilities
  
  self.authorizer = BaseAuthorizer
  
  validates :name, presence: true

  belongs_to :user
  
  has_many :posts, dependent: :restrict_with_error 

  scope :in_order, -> { order('sections.name') }

  delegate :user_name, to: :user, prefix: false

  def without_posts?
    posts_count == 0
  end
end