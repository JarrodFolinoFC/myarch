# frozen_string_literal: true

require 'json'
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

      def publish(arg = nil)
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

      def self.instance(queue_name, config_lookup = nil)
        config = Heart::Core::Config.instance[config_lookup || 'default/rabbit/publish_attributes']
        @instances = {} if @instances.nil?
        @instances[queue_name] ||= DirectPublisher.new(queue_name, config)
      end
    end
  end
end
