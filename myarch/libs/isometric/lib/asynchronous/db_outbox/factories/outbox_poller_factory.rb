# frozen_string_literal: true

module Isometric
  module OutboxPollerFactory
    DEFAULT_DB_MODEL = OutboxMessage
    DEFAULT_PUBLISHER = ::Isometric::OutboxPublisherFactory

    def self.instance(queue, db_model: nil, publisher_factory: nil)
      Isometric::OutboxPoller.new(db_model || DEFAULT_DB_MODEL,
                                  publisher_factory&.new(queue) || DEFAULT_PUBLISHER.instance(queue))
    end
  end
end
