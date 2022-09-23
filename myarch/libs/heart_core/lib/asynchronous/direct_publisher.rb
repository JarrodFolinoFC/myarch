# frozen_string_literal: true

require 'json'
require_relative 'messageable'
require_relative '../config/config'
require 'pry'

module Heart
  module Core
    class DirectPublisher
      include Messageable

      attr_reader :exchange_name, :queue_name, :settings

      def initialize(queue_name, settings = {})
        @exchange_name = settings[:direct_name] || 'direct_name'
        @queue_name = queue_name
        @settings = settings
        create_channel
      end

      def connect_exchange
        evaluated_hash = Heart::Core::Config.evaluate_hash(@settings)
        create_exchange(@exchange_name, @queue_name, evaluated_hash[:routing_key])
        self
      end

      def publish
        evaluated_hash = Heart::Core::Config.evaluate_hash(@settings)
        payload = yield
        exchange.publish(payload, evaluated_hash)
      end

      def publish_with_settings(settings)
        create_exchange(settings[:direct_name], @queue_name, settings[:routing_key])
        payload = yield
        exchange.publish(payload, settings)
      end

      def publish_model(model)
        evaluated_hash = Heart::Core::Config.evaluate_hash(@settings)
        create_exchange(@name, @queue_name, evaluated_hash[:routing_key])
        exchange.publish(model.attributes.to_json,
                         evaluated_hash)
      end

      def self.instance(queue_name, config_lookup = nil)
        config = Heart::Core::Config.instance[config_lookup || 'default/rabbit/publish_attributes']
        @instances = {} if @instances.nil?
        @instances[queue_name] ||= DirectPublisher.new(queue_name, config).connect_exchange
      end
    end
  end
end
