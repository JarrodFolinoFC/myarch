# frozen_string_literal: true

module Isometric
  class QueueManager
    attr_reader :channel

    def initialize(channel)
      @channel = channel
    end

    def purge_all(queues)
      queues.each do |queue|
        @channel.queue_purge(queue) rescue Bunny::NotFound
      end
    end
  end
end
