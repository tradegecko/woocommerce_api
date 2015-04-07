module WoocommerceAPI
  class Resource < Base
    def initialize(data)
      self.assign_attributes(data)
    end

    def assign_attributes(attributes)
      attributes.each do |k, v|
        send(:"#{k}=", v) if self.respond_to? "#{k}="
      end
    end

    class << self
      def resource_name
        self.name.split('::').last.downcase.pluralize
      end

      def all(params={})
        resources = WoocommerceAPI::Resource.http_request(:get, "/#{resource_name}")
        (resources.success? and !resources.nil?) ? resources[resource_name].collect{|r| self.new(r)} : []
      end

      def find(id)
        resource = WoocommerceAPI::Resource.http_request(:get, "/#{resource_name}/#{id}")
        (resource.success? and !resource.nil?) ? self.new(resource[resource_name.singularize]) : nil
      end

      def http_request(verb, url, options={})
        WoocommerceAPI::Base.send(verb, url, options)
      rescue => e
        puts e
      end
    end
  end
end
