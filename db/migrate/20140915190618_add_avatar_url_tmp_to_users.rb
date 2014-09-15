class AddAvatarUrlTmpToUsers < ActiveRecord::Migration
  def change
    add_column :users, :avatar_url_tmp, :string
  end
end
