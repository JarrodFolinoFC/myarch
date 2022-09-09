require_relative 'messageable'
module Heart
  module Core
    class QueueManager
      include Messageable

      def initialize
        msg_connect!
      end

      def purge_all(queues)
        queues.each { |queue| channel.queue_purge(queue) }
      rescue Bunny::NotFound

      end
    end
  end
end