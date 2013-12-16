module RoutesHelper
  def public_profile_path(user)
    "/public/#{user.user_name}"
  end

  def public_posts_path(user)
    "/public/#{user.user_name}/posts"
  end

  def public_section_path(section)
    "/public/#{section.user_name}/section/#{section.id}"
  end

  def public_post_path(post)
    "/public/#{post.user_name}/posts/#{post.id}"
  end

  def public_tag_path(tag)
    "/public/tag/#{tag}"
  end
end