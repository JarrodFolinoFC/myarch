# frozen_string_literal: true

module Isometric
  class PublisherFactory
    def self.instance(queue_name, config_lookup = nil)
      conn = BunnyConnectionFactory.conn
      conn.start
      channel = conn.create_channel
      config = Isometric::Config.instance[config_lookup || 'default/rabbit/publish_attributes']

      exchange_name = config[:direct_name] || DEFAULT_EXCHANGE_NAME
      exchange = channel.direct(exchange_name)
      channel.queue(queue_name, auto_delete: true).bind(exchange, routing_key: config[:routing_key])

      @instances = {} if @instances.nil?
      @instances[queue_name] ||= RabbitPublisher.new(queue_name, channel, exchange, config)
    end
  end
end
