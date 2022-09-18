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
        evaluated_hash = Heart::Core::Config.evaluate_hash(@settings)
        connect_exchange!(@name, @queue_name, evaluated_hash[:routing_key])
        payload = yield
        exchange.publish(payload, evaluated_hash)
      end

      def publish_model(model)
        evaluated_hash = Heart::Core::Config.evaluate_hash(@settings)
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
