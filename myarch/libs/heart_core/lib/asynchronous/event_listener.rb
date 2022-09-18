# frozen_string_literal: true

require 'json'

require_relative 'messageable'
module Heart
  module Core
    class EventListener
      include Messageable

      def initialize(queue, send_confirmation: false)
        @queue = queue
        @send_confirmation = send_confirmation
      end

      def listen
        msg_connect!
        q = channel.queue(@queue, auto_delete: true)
        begin
          q.subscribe(block: true) do |_delivery_info, properties, body|
            yield(body)
            after_send_confirmation(properties) if @send_confirmation
          end
        rescue Interrupt => _e
          conn.close
          exit(0)
        end
      end

      def after_send_confirmation(properties)
        DirectPublisher.instance(properties[:reply_to], 'rabbit/reply_to/publish_attributes').publish do
          {
            correlation_id: properties[:correlation_id]
          }.to_json
        end
      end
    end
  end
end
