require_relative '../../lib/bunny_connection_factory'

conn = BunnyConnectionFactor.get_bunny
channel = conn.create_channel
exchange = channel.direct("test_exchange")
channel.queue("test_queue", :auto_delete => true).bind(exchange, :routing_key => "test_key")
exchange.publish("Hello World!", :routing_key => "test_key")
