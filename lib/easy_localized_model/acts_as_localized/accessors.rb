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
          localized_values = read_attribute(field)
          localization = EasyLocalizedModel::Localization.unserialize(localized_values)

          # Get the corresponding localization
          content =   localization.get(locale)
          content ||= localization.get(I18n.default_locale)

          # No need to check if the content is localized,
          # if it wasn't, the value would already have been set
          content ||= localization.get.values.first
        end  
      end
    end

  end
end