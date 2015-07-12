class DropCommentsBugIdAndPostId < ActiveRecord::Migration
  def change
    remove_column :comments, :bug_id
    remove_column :comments, :post_id
  end
end
