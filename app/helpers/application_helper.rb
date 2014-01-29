module ApplicationHelper

  def page_header(main_text, small_text = nil)
    content_tag :div, class: 'page-header' do
      content_tag :h1 do 
        text = main_text
        text += content_tag :small, small_text if small_text
        raw text
      end
    end
  end

  def icon(name, text = nil)
    result = content_tag :i, '', class: "fa fa-#{name.to_s}"
    result += raw("&nbsp; #{text}") if text
    result
  end

  def edit_link(model, href = nil)    
    href ||= url_for [:edit, :user, model]
    pluralized_class_name = model.class.name.downcase.pluralize
    content_tag :a, icon(:edit), href: href, class: 'edit', title: I18n.t("links.#{pluralized_class_name}.edit")
  end

  def page_header
    content_tag :h2, t('.page_header')
  end

  def spacer 
    content_tag :div, '', class: 'spacer'
  end

  def menu_item(title, href, icon_name = nil)
    text = icon_name ? icon(icon_name, title) : title
    content_tag :li, content_tag(:a, text, href: href)
  end

  def menu_divider
    content_tag :li, '', class: 'divider'
  end

  def scroll_to_top
    content_tag :a, icon('arrow-circle-o-up'), href: '#scroll-to-top', id: 'scroll-to-top', title: I18n.t('links.back_to_top')
  end
end
