class FillUsersAvatarUrlTmp < ActiveRecord::Migration
  def up
    User.find_each { |user| user.update avatar_url_tmp: user.avatar_url(:thumb) }
  end

  def down
    User.update_all avatar_url_tmp: nil
  end
end
