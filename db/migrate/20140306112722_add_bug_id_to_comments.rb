class AddBugIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :bug_id, :integer
  end
end
