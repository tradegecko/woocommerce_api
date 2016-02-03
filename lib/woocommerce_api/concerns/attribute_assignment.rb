module WoocommerceAPI
  module AttributeAssignment
    def assign_attributes(new_attributes)
      return if new_attributes.blank?
      new_attributes.each do |attr, value|
        public_send("#{attr}=", value)
      end
    end

    def update_attributes(new_attributes={})
      assign_attributes(new_attributes)
      save
    end
  end
end
