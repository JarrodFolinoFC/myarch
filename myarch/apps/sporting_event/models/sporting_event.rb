# frozen_string_literal: true

require 'json'
require_relative '../../../lib/ruby/serializable'

class SportingEvent < ActiveRecord::Base
  include Serializable

  def self.serialized_attrs
    %i[internal_id name event_date venue location version uuid]
  end

  # def to_h
  #   %i[internal_id name event_date venue location version uuid].inject({}) do |hash, key|
  #     hash[key] = send(key)
  #   end
  # end

  # after_create do
  #   puts self.class.serialized_attrs.join(', ')
  #   EventPublisher
  #     .new('test_exchange', 'sporting_event_created', 'key1')
  #     .send do
  #     #   to_json
  #     '{}'
  #   end
  # end

  def to_s
    "#{self.class} id: #{id}"
  end
end
