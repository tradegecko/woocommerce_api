module WoocommerceAPI
  module V2
    class Image < Resource
      attribute :id, Integer
      attribute :src
      attribute :position, Integer

      # Read Only
      attribute :date_created, DateTime, writer: :private
      attribute :date_modified, DateTime, writer: :private
      attribute :title     , String  , writer: :private
      attribute :alt       , String  , writer: :private
    end
  end
end
