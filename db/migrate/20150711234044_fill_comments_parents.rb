class FillCommentsParents < ActiveRecord::Migration
  def change
    execute "UPDATE comments SET parent_type = 'Post', parent_id = post_id WHERE type = 'Comment'"
    execute "UPDATE comments SET parent_type = 'Bug', parent_id = bug_id WHERE type = 'Comment'"
  end
end
