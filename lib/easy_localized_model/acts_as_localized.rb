module EasyLocalizedModel
  module ActsAsLocalized
    extend ActiveSupport::Concern    
    
    included do
    end
    
    module ClassMethods

      # For each field, redefine the accessors and assessors
      def localize(*fields)
        class_eval do
          include EasyLocalizedModel::ActsAsLocalized::Accessors[:fields => fields]
          include EasyLocalizedModel::ActsAsLocalized::Assessors[:fields => fields]
        end
      end
    end
  end
end


ActiveRecord::Base.send(:include, EasyLocalizedModel::ActsAsLocalized)
