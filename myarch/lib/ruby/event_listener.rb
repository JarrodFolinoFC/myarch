# frozen_string_literal: true

require 'json'

require_relative 'messageable'

class EventListener
  include Messageable

  def initialize(queue)
    @queue = queue
  end

  def listen
    msg_connect!
    q = channel.queue(@queue, auto_delete: true)
    begin
      q.subscribe(block: true) do |_delivery_info, _properties, body|
        yield(body)
      end
    rescue Interrupt => _e
      conn.close
      exit(0)
    end
  end
end
