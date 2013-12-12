class AddPostsCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :posts_count, :integer, :default => 0
    User.reset_column_information
    User.find_each do |user|
      User.update_counters user.id, :posts_count => user.posts.length
    end
  end
end
