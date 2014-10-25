class Claim < ActiveRecord::Base
  belongs_to :post

  validates :email, format: { with: Devise.email_regexp }, allow_blank: true

  scope :in_order, -> { order('claims.created_at DESC') }
end