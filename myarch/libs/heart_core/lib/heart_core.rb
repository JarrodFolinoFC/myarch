%w[
active_record/active_model_helper
active_record/outbox_acks
active_record/outbox_message
asynchronous/event_listener
asynchronous/direct_publisher
asynchronous/messageable
asynchronous/queue_manager
asynchronous/outbox_publisher
asynchronous/outbox_publisher
config/app_config
config/app_shared_config
config/config
config/configuration_dsl
config/defaults
discovery/registry
abstractions/bunny_connection_factory
abstractions/db_connection
abstractions/logger
].each do |lib|
  require_relative lib
end
