require 'rouge'
require 'rouge/plugins/redcarpet'

module Redcarpeted
  extend ActiveSupport::Concern
  
  class MarkdownRenderer < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet
    include ActionView::Helpers::UrlHelper

    def link(link, title, content)
      link_to content, link, title: title, rel: 'nofollow', target: '_blank'
    end

    def autolink(link, link_type)
      link_to link, link, rel: 'nofollow', target: '_blank'
    end
  end

  def self.md2html(text)
    unless text.nil?
      renderer = MarkdownRenderer.new(:filter_html => true, :hard_wrap => true, prettify: true)
      options = {
        fenced_code_blocks: true,
        autolink: true
      }
      markdown = Redcarpet::Markdown.new(renderer, options)
      markdown.render(text)
    end
  end

  module ClassMethods
    def redcarpet(field_name)
      method_name = "convert_#{field_name}_to_html!".to_sym
      html_field_name = "#{field_name}_html".to_sym
      define_method method_name do |force = false|
        if force || send("#{field_name}_changed?".to_sym)
          text = read_attribute(field_name)
          write_attribute(html_field_name, Redcarpeted.md2html(text))
        end
      end

      before_save method_name
    end
  end
end