require_relative '../active_record/outbox_message'
require_relative 'event_publisher'
module Heart
  module Core
    class PollingPublisher

      def run
        while true do
          OutboxMessage.where(sent_at: nil).each do |msg|
            EventPublisher.fetch_instance(msg.queue).publish do
              msq.payload
            end
            msg.update(sent_at: Time.now)
          end
        end

      end

    end
  end
end
