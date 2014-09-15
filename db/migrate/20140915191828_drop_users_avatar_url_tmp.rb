class DropUsersAvatarUrlTmp < ActiveRecord::Migration
  def change
    remove_column :users, :avatar_url_tmp
  end
end
