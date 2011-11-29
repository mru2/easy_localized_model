module EasyLocalizedModel::ActsAsLocalized
  module Assessors
    include Paramix::Parametric

    parameterized do |params|
      params[:fields].each do |field|
        # Override the assessor
        define_method "#{field}=" do |value|
          send "set_#{field}", value
        end

        # Extra assessor for forcing locale
        define_method "set_#{field}" do |value, options = {}|
          locale = (options[:locale] or I18n.locale)
          localizations = EasyLocalizedModel::Localization.unserialize(read_attribute(field))
          localizations.set(value, locale)
          write_attribute(field, localizations.serialize)
        end
      end
    end

  end
end