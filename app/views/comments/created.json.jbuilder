json.message I18n.t('comments.create.success')
json.id @comment.id
json.body @comment.body_html
json.url public_comment_url(@comment)
json.date I18n.l(@comment.created_at)
json.author do 
  json.avatar @comment.user_avatar_url(:thumb)
  json.name @user.user_name
  json.url public_profile_path(@user)
end