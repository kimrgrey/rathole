class AddParentIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :parent_id, :integer
    add_column :comments, :parent_type, :string
    add_index :comments, [:parent_type, :parent_id]
  end
end
