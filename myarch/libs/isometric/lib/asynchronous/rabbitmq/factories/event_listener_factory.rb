# frozen_string_literal: true

module Isometric
  class EventListenerFactory
    def self.instance(queue_name)
      # settings = Isometric::Config.instance[config_lookup || 'default/rabbit/listener_attributes']
      @instances = {} if @instances.nil?
      conn = BunnyConnectionFactory.conn
      conn.start
      ch = conn.create_channel
      queue = ch.queue(queue_name, auto_delete: true)
      @instances[queue_name] ||= EventListener.new(queue)
    end
  end
end
