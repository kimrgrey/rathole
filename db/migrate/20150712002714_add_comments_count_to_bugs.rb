class AddCommentsCountToBugs < ActiveRecord::Migration
  def change
    add_column :bugs, :comments_count, :integer
  end
end
