module WoocommerceAPI
  module V2
    class Tool < Resource
      attribute :id
      attribute :confirm, Boolean

      attribute :name, String, writer: :private
      attribute :action, String, writer: :private
      attribute :description, String, writer: :private
      attribute :success, Boolean, writer: :private
      attribute :message, String, writer: :private
    end
  end
end
