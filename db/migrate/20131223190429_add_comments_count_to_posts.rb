class AddCommentsCountToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :comments_count, :integer, default: 0
    Post.reset_column_information
    Post.find_each do |post|
      Post.update_counters post.id, :comments_count => post.comments.length
    end

  end
end
