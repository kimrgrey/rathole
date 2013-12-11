class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, 
         :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable

  validates :user_name, uniqueness: true

  has_many :posts
end
