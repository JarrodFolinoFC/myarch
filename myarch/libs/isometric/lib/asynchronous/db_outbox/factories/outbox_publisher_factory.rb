# frozen_string_literal: true

module Isometric
  module OutboxPublisherFactory
    def self.instance(queue_name, config_lookup = nil)
      config = Isometric::Config.instance[config_lookup || 'default/rabbit/publish_attributes'] || {}
      @instances = {} if @instances.nil?
      @instances[queue_name] ||= Isometric::OutboxPublisher.new(queue_name, config)
    end
  end
end
