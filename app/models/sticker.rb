class Sticker < ActiveRecord::Base
  POST_NUMBER_1     = 'post_number_1'.freeze
  POST_NUMBER_10    = 'post_number_10'.freeze
  POST_NUMBER_100   = 'post_number_100'.freeze
  BEST_AUTHOR       = 'best_author'.freeze
  BEST_COMMENTATOR  = 'best_commentator'.freeze
  BEST_CORRECTOR    = 'best_corrector'.freeze

  validates :code, presence: true
  validates :picture, presence: true

  has_and_belongs_to_many :users

  def self.with_code(code)
    Sticker.where(code: code).first 
  end

  def self.codes
    [
      Sticker::POST_NUMBER_1, Sticker::POST_NUMBER_10, Sticker::POST_NUMBER_100,
      Sticker::BEST_AUTHOR, Sticker::BEST_COMMENTATOR, Sticker::BEST_CORRECTOR
    ]
  end
end