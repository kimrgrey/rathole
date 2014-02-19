module Hstorable
  extend ActiveSupport::Concern

  module ClassMethods
    def hstore(hstore_field_name, property_name, options = {})
      options[:class_name] = property_name.to_s.singularize.camelize unless options.has_key?(:class_name)
      
      property_class = options[:class_name].to_s.constantize
      define_method property_name do
        hstore_field = self.send(hstore_field_name)
        property_class.find(hstore_field[property_name.to_s]) if hstore_field[property_name.to_s].present?
      end

      define_method "#{property_name}=" do |model|
        hstore_field = self.send(hstore_field_name)
        self.send("#{hstore_field_name}_will_change!") if hstore_field[property_name.to_s] != model.id
        hstore_field[property_name.to_s] = model.id
      end
    end
  end
end