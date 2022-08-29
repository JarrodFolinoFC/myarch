# frozen_string_literal: true

module Serializable
  def self.included(base)
    base.send :include, InstanceMethods
    base.extend ClassMethods
  end

  module InstanceMethods
    def as_json(_options = {})
      self.class.serialized_attrs.inject({}) do |hash, key|
        hash[key] = send(key)
      end
    end

    def to_json(*options)
      as_json(*options).to_json(*options)
    end
  end

  module ClassMethods
    def from_json(json)
      payloads = JSON.parse(json)
      payloads.map do |payload|
        object = new
        payload.keys { |k, v| object.send("#{k}=", v) if object.respond_to?("#{k}=") }
        object
      end
    end
  end
end
