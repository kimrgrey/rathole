json.id post.id
json.title post.title
json.preview post.preview_html if post.preview_updated_at >= @lsd
json.body post.body_html if post.body_updated_at >= @lsd
json.tags post.tags
json.user_id post.user_id
json.visible_on_main post.visible_on_main
json.created_at post.created_at.to_i
json.updated_at post.updated_at.to_i
json.comments post.comments do |comment|
  json.id comment.id
  json.user_id comment.user_id
  json.body comment.body_html if comment.body_updated_at >= @lsd
  json.created_at comment.created_at.to_i
  json.updated_at comment.updated_at.to_i
end