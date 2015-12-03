module WoocommerceAPI
  class  WebhookDelivery < Resource
    attribute :id, Integer
    attribute :duration
    attribute :summary
    attribute :request_method
    attribute :request_url
    attribute :request_headers, Hash
    attribute :request_body
    attribute :response_code
    attribute :response_message
    attribute :response_headers, Hash
    attribute :response_body
    attribute :created_at, DateTime
  end
end
