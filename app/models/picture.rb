class Picture < ActiveRecord::Base
  mount_uploader :image, PictureUploader
end