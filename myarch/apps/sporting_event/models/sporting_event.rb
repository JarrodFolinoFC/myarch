# frozen_string_literal: true

require 'json'
require_relative '../../../lib/ruby/serializable'

class SportingEvent < ActiveRecord::Base
  include Serializable

  def self.serialized_attrs
    %i[internal_id name event_date venue location version uuid]
  end

  def to_s
    "#{self.class} id: #{id}"
  end
end
