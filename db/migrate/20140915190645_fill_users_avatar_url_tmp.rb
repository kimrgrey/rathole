class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    ActionController::Base.helpers.asset_path([version_name, "avatar_default.png"].compact.join('_'))
  end

  version :thumb do
    process :resize_to_fill => [200,200]
  end

  version :small do
    process :resize_to_fill => [50,50]
  end
end

class User
  mount_uploader :avatar, AvatarUploader
end

class FillUsersAvatarUrlTmp < ActiveRecord::Migration
  def up
    User.find_each { |user| user.update avatar_url_tmp: user.avatar_url(:thumb) }
  end

  def down
    User.update_all avatar_url_tmp: nil
  end
end
