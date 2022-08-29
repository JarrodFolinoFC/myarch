# frozen_string_literal: true

require_relative 'bunny_connection_factory'

module Messageable
  attr_reader :conn, :channel, :exchange

  def msg_connect!
    @conn = BunnyConnectionFactor.get_bunny
    @conn.start
    @channel = @conn.create_channel
  end

  def connect_exchange!(direct, queue_name, routing_key)
    @exchange = channel.direct(direct)
    channel.queue(queue_name, auto_delete: true).bind(@exchange, routing_key: routing_key)
    @exchange
  end
end
