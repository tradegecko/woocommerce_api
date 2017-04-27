module WoocommerceAPI
  module ParamsConverter
    module ClassMethods
      DATE_KEYS = [:after, :before].freeze
      EXCLUDE_FROM_FILTER_HASH = [:page, :force].freeze
      ALLOWABLE_PARAMS = [
        :after, :attribute_term, :attribute, :before, :category, :context,
        :customer, :email, :exclude, :fields, :filter, :force, :include, :offset,
        :order, :orderBy, :page, :per_page, :role, :search, :shipping_class, :sku,
        :slug, :status, :tag
      ].freeze

      KEYS_MAPPING = {
        after: :created_at_min,
        before: :created_at_max,
        per_page: :limit
      }.freeze

      def converted_params(params)
        params = converted_date_params(params)
        if legacy_api?
          if params[:status] && self.singleton_name == "product"
            status = params.delete(:status)
            status = "published" if status == "publish"
            params[:post_status] = status
          end

          included_in_filter_params = params.slice!(*EXCLUDE_FROM_FILTER_HASH)

          if included_in_filter_params.present?
            { filter: remapped_params(included_in_filter_params) }.merge(params)
          else
            params
          end
        else
          params
        end.slice(*ALLOWABLE_PARAMS)
      end

      def remapped_params(params)
        params.map do |key, value|
          KEYS_MAPPING[key] ? [KEYS_MAPPING[key], value] : [key, value]
        end.to_h
      end

      def converted_date_params(params)
        # Woocommerce requires all dates to be in RFC3339 format
        # in UTC timezone: YYYY-MM-DDTHH:MM:SSZ

        if (params.keys & DATE_KEYS).present?
          date_params = params.slice(*DATE_KEYS)
          date_params.update(date_params) { |key, value| value.to_datetime.strftime("%FT%TZ") }
          params.merge!(date_params)
        end

        params
      end
    end

    def self.included(receiver)
      receiver.extend ClassMethods
    end
  end
end
