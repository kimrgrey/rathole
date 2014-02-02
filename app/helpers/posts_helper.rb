module PostsHelper
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

  def public_link(post)
    link_to  public_post_url(post), title: I18n.t("links.posts.public"), class: 'public-link' do 
      icon 'link'
    end
  end

  def public_comment_link(comment) 
    id = "comment-#{comment.id}"
    url = public_post_url(comment.post) + "##{id}"
    link_to url, class: 'public-link', id: id do 
      icon 'link'
    end
  end

  def without_emoji(text)
    text.gsub(/:([a-z0-9\+\-_]+):/) do |match|
      name = $1
      Emoji.names.include?(name) ? '' : name
    end
  end
end