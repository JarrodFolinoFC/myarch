# frozen_string_literal: true

require_relative '../../../lib/ruby/bunny_connection_factory'
require 'json'
require 'csv'

class SportingEventPublisher
  def initialize
    @conn = BunnyConnectionFactor.get_bunny
    channel = @conn.create_channel
    @exchange = channel.direct('test_exchange')
    channel.queue('sporting_event_create', auto_delete: true).bind(@exchange, routing_key: 'key1')
  end

  def parse_csv(file)
    data = []
    CSV.foreach(file, headers: true, col_sep: '|') do |row|
      data << {
        internal_id: row['internal_id'],
        name: row['name'],
        event_date: row['event_date'],
        venue: row['venue'],
        location: row['location']
      }
    end
    data
  end

  def send(data_file)
    json = parse_csv(data_file).to_json
    @exchange.publish(json, routing_key: 'key1')
  end
end
