class Import < ActiveRecord::Base
  enum state: [ :created, :started, :working, :finished ]

  scope :in_order, -> { order('imports.created_at DESC') }

  def lj_url
    "http://#{lj_user}.livejournal.com/"
  end
end