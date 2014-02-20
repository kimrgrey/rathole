class StatisticalRecord < ActiveRecord::Base
  validates :date, presence: true, uniqueness: true
  validates :users_count, presence: true
  validates :posts_count, presence: true
  validates :events_count, presence: true

  def self.collect_and_save!
    record = StatisticalRecord.new
    record.users_count = User.count
    record.posts_count = Post.count
    record.events_count = Events::Event.count
    record.date = Date.today
    record.save!
  end
end