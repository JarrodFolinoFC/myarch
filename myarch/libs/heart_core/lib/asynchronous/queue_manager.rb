module Heart
  module Core
    class QueueManager
      attr_reader :conn, :channel, :exchange

      def initialize
        @conn = BunnyConnectionFactory.conn
        @conn.start
        @channel = @conn.create_channel
      end

      def purge_all(queues)
        queues.each { |queue| @channel.queue_purge(queue) }
      rescue Bunny::NotFound

      end
    end
  end
end