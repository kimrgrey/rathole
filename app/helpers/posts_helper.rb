module PostsHelper
  def tags(tags)
    icon 'tags', tags.map{|tag| content_tag :a, tag, href: public_tag_path(tag)}.join(', ')
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
    link_to url, class: 'public-link' do 
      icon 'link'
    end
  end

  def without_emoji(text)
    text.gsub(/:([a-z0-9\+\-_]+):/) do |match|
      name = $1
      Emoji.names.include?(name) ? '' : name
    end
  end

  def post_on_main_link(post)
    if post.visible_on_main?
      link_to icon('eye-slash'), hide_from_main_admin_post_path(post), method: 'post'
    else
      link_to icon('eye'), show_on_main_admin_post_path(post), method: 'post'
    end
  end

  def post_subscription_link(user, post)
    if user.subscribed_on?(post)
      link_to icon('bookmark'), subscriptions_user_path(post_id: post.id), title: I18n.t('users.subscribe.title.post'), method: 'delete'
    else
      link_to icon('bookmark-o'), subscriptions_user_path(post_id: post.id), title: I18n.t('users.unsubscribe.title.post'), method: 'post'
    end
  end

  def post_bug_link(post)
    link_to icon('bug'), '#show-bug-dialog', class: 'bug-in-post'
  end
end