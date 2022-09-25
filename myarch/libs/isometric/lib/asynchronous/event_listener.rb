# frozen_string_literal: true

require 'json'

module Isometric
  class EventListener
    def initialize(queue)
      @queue = queue
    end

    def listen
      Isometric::Logger.instance.info("#{self.class} started on queue: #{@queue}")
      @queue.subscribe(block: true) do |_delivery_info, _metadata, payload|
        yield(payload)
        Isometric::Logger.instance.info('Message Processed')
      end
    end

    def after_send_confirmation(_delivery_info, properties, _body)
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
