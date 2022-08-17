require "kafka"
require "json"

seed_brokers = ['localhost:29092']
application_name = application_name
topic = "test-messages"


kafka = Kafka.new(seed_brokers, client_id: application_name)

# Instantiate a new producer.
producer = kafka.async_producer

# https://github.com/zendesk/ruby-kafka/wiki/Encoding-messages-with-Avro
event = {
  "name" => "pageview",
  "url" => "https://example.com/posts/123",
}

data = JSON.dump(event)

producer.produce(data, topic: "events")

# Deliver the messages to Kafka.
producer.deliver_messages