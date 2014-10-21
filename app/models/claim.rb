class Claim < ActiveRecord::Base
  belongs_to :post, touch: true

  validates :post, presence: true

  scope :in_order, -> { order('claims.created_at DESC') }
end