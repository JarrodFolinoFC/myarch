# frozen_string_literal: true

require_relative '../active_record/outbox_message'
module Heart
  module Core
    class OutboxPublisher
      DEFAULT_MODEL_CLASS = ''
      DEFAULT_HEADERS = {}

      def initialize(direct, queue_name, routing_key)
        @name = direct
        @queue_name = queue_name
        @routing_key = routing_key
      end

      def publish
        payload = yield
        do_publish(payload)
      end

      def publish_model(model)
        do_publish(model.attributes)
      end

      def self.fetch_instance(queue_name, overrides = {})
        direct = ENV['RABBIT_EXCHANGE_NAME'] || '' # Default
        routing_key = ENV['RABBIT_ROUTING_KEY'] || 'mykey'
        @instance ||= OutboxPublisher.new(direct, queue_name, routing_key)
      end

      private

      def do_publish(payload)
        Heart::Core::OutboxMessage.create!(
          queue: @queue_name,
          payload: payload,
          headers: DEFAULT_HEADERS,
          sent_at: Time.now
        )
      end
    end
  end
end
