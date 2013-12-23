module RoutesHelper
  def public_profile_path(user, options = nil)
    args = { controller: 'public', action: 'profile'}
    args = args.merge(user_name: user.user_name)
    args = args.merge(options) if options
    url_for args
  end

  def public_posts_path(user, options = nil)
    args = { controller: 'public', action: 'posts'}
    args = args.merge(user_name: user.user_name)
    args = args.merge(options) if options
    url_for args
  end

  def public_section_path(section, options = nil)
    args = { controller: 'public', action: 'section'}
    args = args.merge(user_name: section.user_name, id: section.id)
    args = args.merge(options) if options
    url_for args
  end

  def public_post_path(post, options = nil)
    args = { controller: 'public', action: 'post'}
    args = args.merge(user_name: post.user_name, id: post.id)
    args = args.merge(options) if options
    url_for args
  end

  def public_tag_path(tag, options = nil)
    args = { controller: 'public', action: 'posts'}
    args = args.merge(tag: tag)
    args = args.merge(options) if options
    url_for args
  end
end