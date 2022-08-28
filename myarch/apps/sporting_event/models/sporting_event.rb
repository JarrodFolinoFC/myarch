# frozen_string_literal: true

require 'json'

class SportingEvent < ActiveRecord::Base
  def as_json(_options = {})
    %i[internal_id name event_date venue location version uuid].inject({}) do |hash, key|
      hash[key] = send(key)
    end
  end

  def to_json(*options)
    as_json(*options).to_json(*options)
  end

  def self.from_json(json)
    objects = JSON.parse(json)

    objects.map do |object|
      se = SportingEvent.new
      object.keys do |k, v|
        se.send("#{k}=", v) if se.respond_to?("#{k}=")
      end
      se
    end
  end

  def to_s
    "#{self.class} id: #{id}"
  end
end
