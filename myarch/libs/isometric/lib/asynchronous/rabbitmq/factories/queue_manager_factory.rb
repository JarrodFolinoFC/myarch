# frozen_string_literal: true

module Isometric
  class QueueManagerFactory
    def self.instance
      conn = BunnyConnectionFactory.conn
      conn.start
      channel = conn.create_channel
      Isometric::QueueManager.new(channel)
    end
  end
end
