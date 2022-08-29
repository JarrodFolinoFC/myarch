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
      objects = JSON.parse(json)
      objects.map do |object|
        se = new
        object.keys do |k, v|
          se.send("#{k}=", v) if se.respond_to?("#{k}=")
        end
        se
      end
    end
  end
end
