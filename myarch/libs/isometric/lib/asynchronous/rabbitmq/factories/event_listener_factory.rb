# frozen_string_literal: true

module Isometric
  class EventListenerFactory
    DEFAULT_CLASS = Isometric::EventListener
    def self.instance(queue_name, klass: nil, settings: {})
      # settings = Isometric::Config.instance[config_lookup || 'default/rabbit/listener_attributes']
      @instances = {} if @instances.nil?
      conn = BunnyConnectionFactory.conn
      conn.start
      ch = conn.create_channel
      queue = ch.queue(queue_name, auto_delete: true)
      klass ||= DEFAULT_CLASS
      # one listener per queue
      @instances[queue_name] ||= klass.new(queue, settings)
    end
  end
end
