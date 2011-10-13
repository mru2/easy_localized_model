module EasyLocalizedModel

  class LocalizationHash < Hash
    def initialize(hash)
      replace(hash.symbolize_keys!)
    end
  end

end