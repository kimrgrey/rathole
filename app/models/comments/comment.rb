class Comments::Comment < ActiveRecord::Base
  paginates_per 50

  include Authority::Abilities

  self.authorizer_name = 'CommentAuthorizer'

  include Redcarpeted
  
  redcarpet :body

  validates :body, presence: true
  
  scope :in_order, ->{ order('comments.created_at DESC') }

  delegate :user_name, to: :user, prefix: false
  delegate :avatar_path, to: :user, prefix: true
end