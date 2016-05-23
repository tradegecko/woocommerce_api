module WoocommerceAPI
  class OrderNote < Resource
    attribute :id, Integer
    attribute :customer_note, Boolean
    attribute :note

    # Read Only
    attribute :created_at, DateTime, writer: :private

    def self.collection_path(prefix_options='', param_options=nil)
      "/orders/#{@order_id}/notes/"
    end

    def self.all(order_id)
      return [] unless order_id
      @order_id = order_id
      super({})
    end

    def find(order_id, id)
      @order_id = order_id
      super(id)
    end

    def self.create(order_id, attributes)
      @order_id = order_id
      super(attributes)
    end
  end
end
