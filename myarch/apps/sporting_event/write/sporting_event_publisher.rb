require_relative '../../../lib/ruby/bunny_connection_factory'

class SportingEventPublisher
  def initialize
    @conn = BunnyConnectionFactor.get_bunny
    channel = @conn.create_channel
    @exchange = channel.direct("test_exchange")
    channel.queue("test_queue", :auto_delete => true).bind(@exchange, :routing_key => "test_key")
  end

  def hello
    @exchange.publish("Hello World 2!", :routing_key => "test_key")
  end
end
