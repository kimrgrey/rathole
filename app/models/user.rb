class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, 
         :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable

  validates :user_name, uniqueness: true

  has_many :posts

  def last_posts(count = 5) 
    posts.order('posts.created_at DESC').limit(count)
  end
end
