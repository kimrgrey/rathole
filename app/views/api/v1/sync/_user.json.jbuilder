json.id user.id
json.user_name user.user_name
json.avatar full_image_url(user.avatar_path)
json.created_at user.created_at.to_i
json.updated_at user.updated_at.to_i
json.last_sign_in_at user.last_sign_in_at.to_i
