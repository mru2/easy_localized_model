module EasyLocalizedModel::ActsAsLocalized
  module Accessors
    include Paramix::Parametric

    parameterized do |params|
      params[:fields].each do |field|
        # Override the accessor
        define_method "#{field}" do |locale = nil|
          # Get the current locale if none specified
          locale ||= I18n.locale

          # Get the localizations values
          raw_value = read_attribute(field)
          value = EasyLocalizedModel::Localization.unserialize(raw_value)

          # Get the corresponding localization
          localization =   value.get(locale)
          localization ||= value.get(I18n.default_locale)

          # No need to check if the content is localized,
          # if it wasn't, the value would already have been set
          localization ||= value.get.values.first if value.is_localization?
        end  
      end
    end

  end
end