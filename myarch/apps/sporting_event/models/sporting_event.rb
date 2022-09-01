# frozen_string_literal: true

require 'json'

class SportingEvent < ActiveRecord::Base
  after_create do
    EventPublisher.fetch_instance('sporting_event_created').send_model(self)
  end
end
