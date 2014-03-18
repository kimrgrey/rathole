if @picture.valid?
  json.message I18n.t('pictures.create.success')
  json.urls do 
    json.original full_image_url(@picture.image_url)
    json.thumb full_image_url(@picture.image_url(:thumb))
    json.destroy destroy_picture_path(@picture)
  end
else
  json.message I18n.t('pictures.create.failed')
  json.errors @picture.errors.full_messages
end