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

  def publish_link(post)
    options = {
      href: publish_user_post_path(post), 
      title: I18n.t("posts.publish.#{post.state}.hint"),
      data: { method: 'post'}
    }
    content_tag :a, options do 
      icon(post.published? ? 'unlock' : 'lock')
    end
  end
end