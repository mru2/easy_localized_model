module EasyLocalizedModel

  class Localization

    # Constructor
    def initialize(content, options = {})
      set(content)
      self
    end
    
    # Write and get from the DB
    def serialize
      if is_localization?
        @content.to_json
      else
        @content
      end
    end
    
    def self.unserialize(db_value)
      begin
        parsed_value = JSON.parse db_value
      rescue Exception => e
        # If the data cannot be unserialized, keep it's original value
        return Localization.new(db_value)
      end

      parsed_value.symbolize_keys! if parsed_value.is_a? Hash
      return Localization.new(parsed_value)
    end

    # Is the content localized or not  
    def is_localization?
      @content.is_a? LocalizationHash
    end

    # Get the content
    def get(locale= nil)
      if is_localization? && locale
        @content[locale]
      else
        @content
      end
    end
    
    # Set the content
    def set(content, locale= nil)
      value = (locale && !content.is_a?(Hash)) ? {locale.to_sym => content} : content
      if value.is_a? Hash
        if is_localization?
          @content = @content.merge(value)
        else
          @content = LocalizationHash.new(value)
        end
      else
        @content = value
      end
    end
    
    # Test equality
    def ==(other)
      if other.is_a? Localization
        get == other.get
      else
        @content == other
      end
    end
    
  end

end