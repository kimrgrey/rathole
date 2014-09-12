class AddUniqueConstraintOnUserName < ActiveRecord::Migration
  def up
    change_column :users, :user_name, :string, null: false, unique: true
  end

  def down
    change_column :users, :user_name, :string
  end
end
