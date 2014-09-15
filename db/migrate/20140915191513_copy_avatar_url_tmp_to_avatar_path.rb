class CopyAvatarUrlTmpToAvatarPath < ActiveRecord::Migration
  def change
    User.find_each { |u| u.update avatar_path: u.avatar_url_tmp }
  end
end
