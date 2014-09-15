json.result 'success'
json.message I18n.t('pictures.create.success')  
json.pictures do
  json.array! @pictures do |picture|
    if picture.valid?
      json.id picture.id
      json.urls do 
        json.original full_image_url(picture.image_url)
        json.thumb full_image_url(picture.image_url(:thumb))
        json.destroy destroy_picture_path(picture)
      end
    end
  end
end