require 'kafka'

class KBase

end

class KConnect < KBase
  def deliver_message(message)
    @kafka.deliver_message(message, topic: @topic, partition: 42)
  end

  def fetch_messages
    @kafka.fetch_messages(topic: @topic, partition: 42)
  end
end

class TopicManager
  def initialize(application_name: 'my-application')
    @seed_brokers = ['localhost:29092']
    @application_name = application_name
    @kafka = Kafka.new(@seed_brokers, client_id: @application_name)
  end

  def list_topics
    @kafka.topics
  end

  def create_topics(names)
    puts 'Attempting to create topics: ' + names.join(', ')
    names.uniq.each do |name|
      if !@kafka.has_topic?(name)
        @kafka.create_topic(name)
      else
        puts "Topic: #{name} already exists"
      end
    rescue Kafka::TopicAlreadyExists => e

    end
  end

  def delete_topics(names)
    names.each do |name|
      if @kafka.has_topic?(name)
        @kafka.delete_topic(name)
      else
        puts "Topic: #{name} does not exist"
      end
    end
  end

  def delete_all_topics
    list_topics.each do |name|
      @kafka.delete_topic(name)
    end
  end

  def describe_topics
    list_topics.map do |topic|
      @kafka.describe_topic(topic)
    end
  end
end
