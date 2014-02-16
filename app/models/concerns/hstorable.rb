module Hstorable
  extend ActiveSupport::Concern

  module ClassMethods
    def hstore(hstore_field_name, property_name, property_class_name)
      property_class = property_class_name.to_s.constantize

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