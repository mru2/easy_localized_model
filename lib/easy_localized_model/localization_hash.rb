module EasyLocalizedModel

  class LocalizationHash < Hash
    def initialize(hash)
      replace(hash)
    end
  end

end