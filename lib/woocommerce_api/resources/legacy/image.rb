module WoocommerceAPI
  module V3
    class Image < Resource
      attribute :id, Integer
      attribute :src
      attribute :position, Integer

      # Read Only
      alias_attribute :date_created, :created_at
      alias_attribute :date_modified, :updated_at
      
      attribute :created_at, DateTime, writer: :private
      attribute :updated_at, DateTime, writer: :private
      attribute :title     , String  , writer: :private
      attribute :alt       , String  , writer: :private
    end
  end
end
