require_relative '../active_record/outbox_message'
require_relative 'rabbit_publisher'
require_relative '../factories/publisher_factory'

require 'json'

module Heart
  module Core
    class OutboxPoller
      DEFAULT_DB_MODEL = OutboxMessage
      DEFAULT_PUBLISHER = ::Heart::Core::PublisherFactory

      attr_reader :db_model, :publisher_class

      def initialize(db_model: nil, publisher_class: nil)
        @db_model = db_model || DEFAULT_DB_MODEL
        @publisher_class = publisher_class || DEFAULT_PUBLISHER
      end

      def run
        Heart::Core::Logger.instance.info("#{self.class} started polling #{db_model}")
        loop do
          query = db_model.where(last_published_at: nil).or(db_model.where.not('updated_at != last_published_at'))
          query.each do |msg|
            publisher_class.instance(msg.queue).publish do
              msg.payload
            end
            msg.update(last_published_at: msg.updated_at)
          end
        end
      end
    end
  end
end
