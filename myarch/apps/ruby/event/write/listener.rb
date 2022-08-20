require_relative '../../lib/bunny_connection_factory'

conn = BunnyConnectionFactor.get_bunny
conn.start


channel = conn.create_channel
q = channel.queue("test_queue", :auto_delete => true)
begin
  q.subscribe(block: true) do |_delivery_info, _properties, body|
    puts "[x] Consumed message: []"
    puts body
  end
rescue Interrupt => _
  connection.close
  exit(0)
end