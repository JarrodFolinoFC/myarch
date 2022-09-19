# frozen_string_literal: true

require 'json'

require_relative 'messageable'
module Heart
  module Core
    class EventListener
      include Messageable

      def initialize(queue, send_confirmation: false, settings: nil)
        @queue = queue
        @settings = settings
        @send_confirmation = send_confirmation
      end

      def listen
        create_channel
        q = channel.queue(@queue, auto_delete: @settings[:auto_delete])
        begin
          q.subscribe(block: @settings[:block]) do |_delivery_info, properties, body|
            yield(body)
            after_send_confirmation(_delivery_info, properties, body) if @send_confirmation
          end
        rescue Interrupt => _e
          conn.close
          exit(0)
        end
      end

      def after_send_confirmation(_delivery_info, properties, _body)
        DirectPublisher.instance(properties[:reply_to], 'rabbit/reply_to/publish_attributes').publish do
          {
            correlation_id: properties[:correlation_id],
            application_name: 'App Name',
            message: 'Success'
          }.to_json
        end
      end

      def self.instance(queue_name, send_confirmation: false, config_lookup: nil)
        settings = Heart::Core::Config.instance[config_lookup || 'default/rabbit/listener_attributes']
        @instances = {} if @instances.nil?
        @instances[queue_name] ||= EventListener.new(queue_name, send_confirmation: send_confirmation, settings: settings)
      end
    end
  end
end
