# frozen_string_literal: true

require 'json'
require_relative '../../../lib/ruby/serializable'

class SportingEvent < ActiveRecord::Base
  include Serializable

  def self.serialized_attrs
    %i[internal_id name event_date venue location version uuid]
  end

  def self.sporting_event_created_instance
    @@sporting_event_created ||=
      EventPublisher.new('test_exchange', 'sporting_event_created', 'key1')
  end

  after_create do
    self.class.sporting_event_created_instance
      .send do
      self.to_h.to_json
    end
  end

  def to_h
    {
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
end
