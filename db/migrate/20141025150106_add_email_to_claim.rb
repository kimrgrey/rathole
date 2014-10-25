class AddEmailToClaim < ActiveRecord::Migration
  def change
    add_column :claims, :email, :string
    add_index :claims, :email
  end
end
