module EasyLocalizedModel
  module FormHelper

    def text_area(object_name, method, options = {})
      get_localized_value!(method, options)
      super(object_name, method, options)    
    end

    def text_field(object_name, method, options = {})
      get_localized_value!(method, options)
      super(object_name, method, options)
    end
    
    private 
    
    def get_localized_value!(method, options)
      # Get the object
      object = options[:object]
      
      # Get the translation
      locale = options.delete(:locale)
      if object && (object.respond_to? method)
        value = locale ? object.send(method, locale) : object.send(method)
      end
      
      # Set it as an option
      options[:value] = value if value
    end

  end
end

ActionView::Base.send(:include, EasyLocalizedModel::FormHelper)
