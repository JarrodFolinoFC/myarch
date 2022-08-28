# frozen_string_literal: true

require 'json'

require_relative '../../../lib/ruby/bunny_connection_factory'
require_relative '../db/connection'
require_relative '../models/sporting_event'

class SportingEventListener
  def initialize
    Connection.connect
    @conn = BunnyConnectionFactor.get_bunny
    @conn.start
    @channel = @conn.create_channel
  end

  def listen
    q = @channel.queue('sporting_event_create', auto_delete: true)
    begin
      q.subscribe(block: true) do |_delivery_info, _properties, body|
        se_list = SportingEvent.from_json(body)
        se_list.map(&:save!)
      end
    rescue Interrupt => _e
      connection.close
      exit(0)
    end
  end
end
