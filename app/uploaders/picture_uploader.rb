class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file
  
  def store_dir
    "uploads/pictures/#{model.user_id}/#{model.id}"
  end

  def default_url
    ActionController::Base.helpers.asset_path([version_name, "avatar_default.png"].compact.join('_'))
  end

  version :thumb do
    process :resize_to_fill => [250, 250]
  end
end
