require 'rouge'
require 'rouge/plugins/redcarpet'

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

  class MarkdownRenderer < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet
  end

  def markdown(text)
    renderer = MarkdownRenderer.new(:filter_html => true, :hard_wrap => true, prettify: true)
    options = {
      fenced_code_blocks: true,
      autolink: true
    }
    markdown = Redcarpet::Markdown.new(renderer, options)
    raw markdown.render(text)
  end

  def icon(name, text = nil)
    result = content_tag :i, '', class: "fa fa-#{name.to_s}"
    result += raw("&nbsp; #{text}") if text
    result
  end

  def edit_link(model)    
    content_tag :a, icon(:edit), href: url_for([:edit, model]) , class: 'edit'
  end

  def page_header
    content_tag :h2, t('.page_header')
  end

  def profile_path(user_name)
    
  end
end
