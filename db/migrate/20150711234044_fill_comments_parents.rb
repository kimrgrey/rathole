class FillCommentsParents < ActiveRecord::Migration
  def change
    execute "UPDATE comments SET parent_type = 'Post', parent_id = post_id WHERE post_id IS NOT NULL"
    execute "UPDATE comments SET parent_type = 'Bug', parent_id = bug_id WHERE bug_id IS NOT NULL"
  end
end