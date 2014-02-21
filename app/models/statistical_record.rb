class StatisticalRecord < ActiveRecord::Base
  validates :date, presence: true, uniqueness: true
  validates :comments_count, presence: true
  validates :users_count, presence: true
  validates :posts_count, presence: true
  validates :events_count, presence: true

  def self.collect_and_save!(date = nil)
    date ||= Time.zone.today - 1.day
    record = StatisticalRecord.new
    record.users_count = User.where('users.created_at::date = ?', date).count
    record.posts_count = Post.where('posts.created_at::date = ?', date).count
    record.comments_count = Comment.where('comments.created_at::date = ?', date).count
    record.events_count = Events::Event.where('events.created_at::date = ?', date).count
    record.date = date
    record.save!
  end
end