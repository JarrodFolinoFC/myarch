# frozen_string_literal: true

module Serializable
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def from_json(json)
      payloads = JSON.parse(json)
      payloads = [payloads] unless payloads.instance_of?(Array)
      payloads.map do |payload|
        object = new
        payload.keys { |k, v| object.send("#{k}=", v) if object.respond_to?("#{k}=") }
        object
      end
    end
  end
end
