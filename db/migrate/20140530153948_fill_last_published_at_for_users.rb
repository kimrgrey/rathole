class FillLastPublishedAtForUsers < ActiveRecord::Migration
  def change
    User.all.find_each do |user|
      user.update last_published_at: user.posts.maximum(:published_at)
    end
  end
end
