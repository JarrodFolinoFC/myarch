# frozen_string_literal: true

require_relative '../base_event_listener'
require 'json'

module Isometric
  class EventListener < Isometric::BaseEventListener
    def listen
      Isometric::Logger.instance.info("#{self.class} started on queue: #{@queue}")
      queue.subscribe(block: true) do |_delivery_info, _metadata, payload|
        yield(payload)
        Isometric::Logger.instance.info('Message Processed')
      end
    end
  end
end
