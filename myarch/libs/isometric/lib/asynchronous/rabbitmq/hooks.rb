# frozen_string_literal: true

module Isometric
  module RabbitHooks
    PUBLISH_CONFIRMATION = Proc.new do |_delivery_info, properties, _body|
      PublisherFactory.instance(properties[:reply_to], 'rabbit/reply_to/publish_attributes').publish do
        {
          correlation_id: properties[:correlation_id],
          application_name: 'App Name',
          message: 'Success'
        }.to_json
      end
    end

    CLOSE_CHANNEL = Proc.new do |queue, delivery_info, properties, body|
      channel = queue.channel
      channel.close
      channel.connection.close
    end
  end
end
