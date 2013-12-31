module CacheManagment
  extend ActiveSupport::Concern

  def invalidate_user_cache(user)
    user.posts.find_each { |post| invalidate_post_caches(post) }
  end

  def invalidate_post_caches(post)
    editable, preview = [true, false], [true, false]
    editable.product(preview).each do |preview, editable|
      expire_fragment("post-#{post.id}-#{preview}-#{editable}")
    end
  end
end
