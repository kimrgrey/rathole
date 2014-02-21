class Invite < ActiveRecord::Base
  belongs_to :user
  belongs_to :target, class_name: 'User'

  validates :token, presence: true, uniqueness: true

  before_validation :generate_token!

  def generate_token!
    if token.nil?
      loop do 
        self.token = Devise.friendly_token
        break unless Invite.find_by(token: self.token)
      end
    end
  end
end