class AddNotNullContstraintsForCommentsParentsColumns < ActiveRecord::Migration
  def change
    change_column :comments, :parent_id, :integer, :null => false
    change_column :comments, :parent_type, :string, :null => false
  end
end
