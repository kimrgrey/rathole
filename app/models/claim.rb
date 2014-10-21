class Claim < ActiveRecord::Base
  belongs_to :post, touch: true

  validates :post, presence: true
end