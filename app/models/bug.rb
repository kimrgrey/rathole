class Bug < ActiveRecord::Base
  belongs_to :reporter, class_name: 'User'
  belongs_to :author, class_name: 'User'
  belongs_to :post

  validates :reporter, presence: true
  validates :author, presence: true
  validates :post, presence: true

  enum state: [ :open, :fixed, :rejected ]

  include Redcarpeted

  redcarpet :note

  include Taggable

  scope :in_order, -> { order('bugs.created_at DESC') }
end