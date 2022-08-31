# frozen_string_literal: true

require 'json'

class SportingEvent < ActiveRecord::Base
  after_create do
    self.class.sporting_event_created_instance
      .send do
      self.to_h.to_json
    end
  end

  def to_h
    {
      id: self.id,
      internal_id: self.internal_id,
      name: self.name,
      event_date: self.event_date,
      venue: self.venue,
      version: self.version,
      uuid: self.uuid
    }
  end

  def to_s
    "#{self.class} id: #{id}"
  end

  def self.sporting_event_created_instance
    @@sporting_event_created ||=
      EventPublisher.new('test_exchange', 'sporting_event_created', 'key1')
  end

  def self.build_all(data)
    data = [data] unless data.instance_of?(Array)
    data.map do |props|
      SportingEvent.new(props)
    end
  end
end
