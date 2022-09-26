# frozen_string_literal: true

module Isometric
  module RabbitHook
    class PublishConfirmation
      def process(_delivery_info, properties, _body)
        PublisherFactory.instance(properties[:reply_to], 'rabbit/reply_to/publish_attributes').publish do
          {
            correlation_id: properties[:correlation_id],
            application_name: 'App Name',
            message: 'Success'
          }.to_json
        end
      end
    end
  end
end