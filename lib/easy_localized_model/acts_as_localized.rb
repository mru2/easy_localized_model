module EasyLocalizedModel
  module ActsAsLocalized
    extend ActiveSupport::Concern    
    
    included do
    end
    
    module ClassMethods
      
      def localize(fields = [])
        fields = [fields] unless fields.is_a? Array
        fields.each do |field|

          # Override the accessor
          define_method "#{field}" do |locale = nil|
            field_attribute = read_attribute(field)
            locale ||= I18n.locale
            localization = Localization.unserialize(field_attribute)
            content = localization.get(locale)
            content ||= localization.get(I18n.default_locale)
          end
          
          # Override the assessor
          define_method "#{field}=" do |value|
            send "set_#{field}", value
          end
          
          # Extra assessor for locale forcing
          define_method "set_#{field}" do |value, options = {}|
            locale = options[:locale]
            locale ||= I18n.locale
            localization = Localization.unserialize(read_attribute(field))
            localization.set(value, locale)
            write_attribute(field, localization.serialize)
          end
          
        end
      end
    end
  end
end

ActiveRecord::Base.send(:include, EasyLocalizedModel::ActsAsLocalized)
