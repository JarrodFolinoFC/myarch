# frozen_string_literal: true

require_relative 'messageable'
require_relative '../config/config'

module Heart
  module Core
    class DirectPublisher
      include Messageable

      def initialize(queue_name, settings = {})
        @name = settings[:direct_name] || 'direct_name'
        @queue_name = queue_name
        @settings = settings
        msg_connect!
      end

      def publish
        evaluated_hash = evaluate_hash
        connect_exchange!(@name, @queue_name, evaluated_hash[:routing_key])
        payload = yield
        exchange.publish(payload, evaluated_hash)
      end

      def evaluate_hash
        {
          app_id: @settings[:app_id],
          # user_id: @settings[:user_id],
          routing_key: @settings[:routing_key],
          persistent: @settings[:persistent],
          mandatory: @settings[:mandatory],
          type: @settings[:type],
          reply_to: @settings[:reply_to],
          content_type: @settings[:content_type],
          content_encoding: @settings[:content_encoding],
          priority: @settings[:priority],
          # timestamp: @settings[:timestamp].call,
          # expiration: @settings[:expiration].call,
          message_id: @settings[:message_id].call,
          correlation_id: @settings[:correlation_id].call
        }
      end

      def publish_model(model)
        evaluated_hash = evaluate_hash
        connect_exchange!(@name, @queue_name, evaluated_hash[:routing_key])
        exchange.publish(model.attributes.to_json,
                         evaluated_hash)
      end

      def self.fetch_instance(queue_name)
        default_rabbit_attributes = Heart::Core::Config.instance['default/rabbit/attributes']
        @instance ||= DirectPublisher.new(queue_name, default_rabbit_attributes)
      end
    end
  end
end
