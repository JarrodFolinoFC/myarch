# frozen_string_literal: true

require_relative '../active_record/outbox_message'
module Isometric
  class OutboxPublisher
    def initialize(queue_name, settings)
      @queue_name = queue_name
      @name = settings[:direct]
      @routing_key = settings[:routing_key]
      @settings = settings
    end

    def publish
      payload = yield
      create_outbox_record(payload)
    end

    def publish_model(model)
      create_outbox_record(model.attributes)
    end

    def self.instance(queue_name, config_lookup = nil)
      config = Isometric::Config.instance[config_lookup || 'default/rabbit/publish_attributes']
      @instances = {} if @instances.nil?
      @instances[queue_name] ||= OutboxPublisher.new(queue_name, config)
    end

    private

    def create_outbox_record(payload)
      evaluated_hash = Isometric::Config.evaluate_hash(@settings)
      Isometric::OutboxMessage.create!(
        queue: @queue_name,
        payload: payload.to_json,
        headers: evaluated_hash.to_json
      )
    end
  end
end
