module PostsHelper
  def clip_and_clamp
    content_tag(:span, '', class: 'clip') + content_tag(:span, '', class: 'clamp')
  end

  def tags(tags)
    icon 'tags', tags.map{|tag| content_tag :a, tag, href: public_tag_path(tag)}.join(', ')
  end

  def post_cache_key(post, preview, editable)
    "post-#{post.id}-#{preview}-#{editable}"
  end
end