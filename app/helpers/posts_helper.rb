module PostsHelper
  def clip_and_clamp
    content_tag(:span, '', class: 'clip') + content_tag(:span, '', class: 'clamp')
  end

  def tags(tags)
    icon 'tags', tags.map{|tag| content_tag :a, tag, href: '#'}.join(', ')
  end
end