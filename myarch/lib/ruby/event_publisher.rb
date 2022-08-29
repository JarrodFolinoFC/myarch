# frozen_string_literal: true

require_relative 'messageable'

class EventPublisher
  include Messageable

  def initialize(direct, queue_name, routing_key)
    @direct = direct
    @queue_name = queue_name
    @routing_key = routing_key
    msg_connect!
  end

  def send
    connect_exchange!(@direct, @queue_name, @routing_key)
    payload = yield
    exchange.publish(payload, routing_key: 'key1')
  end
end
