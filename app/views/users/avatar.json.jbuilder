if @user.valid?
  json.message I18n.t('users.avatar.success')
  json.urls do 
    json.original @user.avatar_url
    json.thumb @user.avatar_url(:thumb)
  end
else
  json.message I18n.t('users.avatar.failed')
  json.errors @user.errors.full_messages
end