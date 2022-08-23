require_relative '../../../lib/ruby/bunny_connection_factory'
require_relative '../db/connection'

class SportingEventListener
  def initialize
    Connection.connect
    @conn = BunnyConnectionFactor.get_bunny
    @conn.start
    @channel = @conn.create_channel
  end

  def listen
    q = @channel.queue("test_queue", :auto_delete => true)
    begin
      q.subscribe(block: true) do |_delivery_info, _properties, body|
        puts "[x] Consumed message: []"
        puts body
      end
    rescue Interrupt => _
      connection.close
      exit(0)
    end
  end
end
