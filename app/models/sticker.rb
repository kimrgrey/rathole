class Sticker < ActiveRecord::Base
  POST_NUMBER_1 = 'post_number_1'.freeze
  POST_NUMBER_10 = 'post_number_10'.freeze
  POST_NUMBER_100 = 'post_number_100'.freeze

  validates :code, presence: true
  validates :picture, presence: true

  has_and_belongs_to_many :users

  scope :with_code, ->(code){ Sticker.where(code: code).first }
end