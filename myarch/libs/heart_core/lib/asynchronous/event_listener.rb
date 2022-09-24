# frozen_string_literal: true

require 'json'

module Heart
  module Core
    class EventListener
      def initialize(queue, conn, send_confirmation: false, settings: nil)
        @queue = queue
        @conn = conn
      #   @settings = settings
      #   @send_confirmation = send_confirmation
      end

      def listen
        @conn.start
        ch = @conn.create_channel
        q = ch.queue(@queue, auto_delete: true)
        Heart::Core::Logger.instance.info("#{self.class} started on queue: #@queue")
        q.subscribe(block: true) do |delivery_info, metadata, payload|
          yield(payload)
          Heart::Core::Logger.instance.info("Message Processed")

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

      def self.instance(queue_name)
        # settings = Heart::Core::Config.instance[config_lookup || 'default/rabbit/listener_attributes']
        @instances = {} if @instances.nil?
        conn = BunnyConnectionFactory.conn
        @instances[queue_name] ||= EventListener.new(queue_name, conn)
      end
    end
  end
end
