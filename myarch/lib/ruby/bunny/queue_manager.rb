require_relative 'messageable'

class QueueManager
  include Messageable

  def initialize
    msg_connect!
  end

  def purge_all(queues)
    queues.each {|queue| channel.queue_purge(queue)}
  rescue Bunny::NotFound

  end
end