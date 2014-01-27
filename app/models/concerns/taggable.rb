module Taggable
  extend ActiveSupport::Concern

  def tag_list
    self.tags.join(',')
  end

  def tag_list=(tag_list)
    self.tags = tag_list.split(',').map(&:strip)
  end

  module ClassMethods
    def tagged_with(tag)
      where("#{self.table_name}.tags @> ARRAY[?]", tag)
    end
  end
end
