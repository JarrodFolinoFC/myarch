%w[
active_record/active_model_helper
active_record/outbox_message
asynchronous/bunny_connection_factory
asynchronous/event_listener
asynchronous/direct_publisher
asynchronous/messageable
asynchronous/queue_manager
asynchronous/outbox_publisher
asynchronous/polling_publisher
config/app_config
config/app_shared_config
config/config
config/configuration_dsl
discovery/registry
abstractions/db_connection
].each do |lib|
  require_relative lib
end
