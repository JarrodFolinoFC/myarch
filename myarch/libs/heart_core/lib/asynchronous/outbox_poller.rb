require_relative '../active_record/outbox_message'
require_relative 'direct_publisher'

require 'json'

module Heart
  module Core
    class OutboxPoller

      def run
        while true do
          OutboxMessage.where(sent_at: nil).each do |msg|
            DirectPublisher.instance(msg.queue).publish_with_settings(JSON.parse(msg.headers)) do
              msg.payload
            end
            msg.update(sent_at: Time.now)
          end
        end
      end

    end
  end
end
