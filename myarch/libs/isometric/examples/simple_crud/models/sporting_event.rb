# frozen_string_literal: true

require 'json'

class SportingEvent < ActiveRecord::Base
  after_create do
    # Isometric::DirectPublisher.instance('sporting_event_created').connect_exchange.publish_model(self)
  end
end
