module CacheHelper
  def post_cache_key(post, preview)
    "post:#{post.id}:#{post.updated_at.to_i}:#{preview}"
  end

  def comment_cache_key(comment)
    "comment:#{comment.id}:#{comment.updated_at.to_i}"
  end
end