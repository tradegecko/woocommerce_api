module WoocommerceAPI
  module AttributeAssignment
    def assign_attributes(new_attributes)
      return if new_attributes.blank?
      new_attributes.each do |k,v|
        if respond_to?("#{k}=")
          public_send("#{k}=", v)
        else
          # raise UnknownAttributeError.new(self, k)
          puts 'Error'
        end
      end
    end

    def update_attributes(new_attributes={})
      assign_attributes(new_attributes)
      save
    end
  end
end
