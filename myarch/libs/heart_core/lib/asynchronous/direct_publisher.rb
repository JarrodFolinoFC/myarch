# frozen_string_literal: true

require 'json'

module Heart
  module Core
    class DirectPublisher

      DEFAULT_EXCHANGE_NAME = 'direct_name'

      attr_reader :channel, :exchange
      attr_reader :exchange_name, :queue_name, :settings

      def initialize(queue_name, channel, exchange, settings = {})
        @queue_name = queue_name
        @exchange_name = settings[:direct_name] || DEFAULT_EXCHANGE_NAME
        @settings = settings
        @channel = channel
        @exchange = exchange
      end

      def connect_exchange
        # evaluated_hash = Heart::Core::Config.evaluate_hash(@settings)
        # create_exchange(@exchange_name, @queue_name, evaluated_hash[:routing_key])
        self
      end

      def publish
        evaluated_hash = Heart::Core::Config.evaluate_hash(@settings)
        payload = yield
        exchange.publish(payload, evaluated_hash)
      end

      def publish_with_settings(settings)
        payload = yield
        exchange.publish(payload, settings)
      end

      def publish_model(model)
        evaluated_hash = Heart::Core::Config.evaluate_hash(@settings)
        # create_exchange(@name, @queue_name, evaluated_hash[:routing_key])
        exchange.publish(model.attributes.to_json,
                         evaluated_hash)
      end

      def self.instance(queue_name, config_lookup = nil)
        conn = BunnyConnectionFactory.conn
        conn.start
        channel = conn.create_channel
        config = Heart::Core::Config.instance[config_lookup || 'default/rabbit/publish_attributes']

        exchange_name = config[:direct_name] || DEFAULT_EXCHANGE_NAME
        exchange = channel.direct(exchange_name)
        channel.queue(queue_name, auto_delete: true).bind(exchange, routing_key: config[:routing_key])
        exchange

        @instances = {} if @instances.nil?
        @instances[queue_name] ||= DirectPublisher.new(queue_name, channel, exchange, config)
      end
    end
  end
end
