class RenameAvatarToAvatarPath < ActiveRecord::Migration
  def change
    rename_column :users, :avatar, :avatar_path
  end
end
