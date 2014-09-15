class Picture < ActiveRecord::Base
  mount_uploader :image, PictureUploader

  default_scope -> { where(hidden: false) }

  scope :in_order, -> { order('pictures.created_at DESC') }

  def hide
    update(hidden: true)
  end
end