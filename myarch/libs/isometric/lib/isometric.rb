# frozen_string_literal: true

%w[
  active_record/active_model_helper
  active_record/outbox_acks
  active_record/outbox_message
  asynchronous/event_listener
  asynchronous/rabbit_publisher
  asynchronous/outbox_publisher
  asynchronous/outbox_poller
  asynchronous/queue_manager
  config/config
  config/configuration_dsl
  config/defaults
  discovery/registry
  factories/queue_manager_factory
  factories/bunny_connection_factory
  factories/publisher_factory
  factories/event_listener_factory
  factories/db_connection
  factories/logger
].each do |lib|
  require_relative lib
end
