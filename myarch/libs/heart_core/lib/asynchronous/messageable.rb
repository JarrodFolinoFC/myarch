# frozen_string_literal: true

require_relative '../abstractions/bunny_connection_factory'

module Heart
  module Core
    module Messageable
      attr_reader :conn, :channel, :exchange

      def create_channel
        @conn = BunnyConnectionFactory.get_bunny
        @conn.start
        @channel = @conn.create_channel
      end

      def msg_connect!
        @conn = BunnyConnectionFactory.get_bunny
        @conn.start
        @channel = @conn.create_channel
      end

      def create_exchange(exchange_name, queue_name, routing_key)
        @exchange = channel.direct(exchange_name)
        channel.queue(queue_name, auto_delete: true).bind(@exchange, routing_key: routing_key)
        @exchange
      end
    end
  end
end
