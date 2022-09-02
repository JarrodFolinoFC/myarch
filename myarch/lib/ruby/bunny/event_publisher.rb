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
    exchange.publish(payload, routing_key: @routing_key)
  end

  def send_model(model)
    connect_exchange!(@direct, @queue_name, @routing_key)
    exchange.publish(model.attributes.to_json, routing_key: @routing_key)
  end

  def self.fetch_instance(queue_name)
    direct = ENV['RABBIT_EXCHANGE_NAME'] || 'myexchange'
    routing_key = ENV['RABBIT_ROUTING_KEY'] || 'mykey'
    @instance ||= EventPublisher.new(direct, queue_name, routing_key)
  end
end