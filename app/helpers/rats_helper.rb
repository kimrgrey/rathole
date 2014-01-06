module RatsHelper
  def clip_and_clamp
    content_tag(:span, '', class: 'clip') + content_tag(:span, '', class: 'clamp')
  end

  def keys
    content_tag(:span, '', class: 'keys')
  end

  def painter
    content_tag(:span, '', class: 'painter')
  end
end