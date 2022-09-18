# frozen_string_literal: true

require 'json'

class SportingEvent < ActiveRecord::Base
  after_create do
    Heart::Core::DirectPublisher.instance('sporting_event_created').publish_model(self)
  end
end
