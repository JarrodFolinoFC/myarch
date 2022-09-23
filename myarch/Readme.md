# HC todos
* regression test
* listener DB inbox
* listener publish to auto response listener
* grape swagger
  * strong etags: https://gemdocs.org/gems/grape-app/0.10.1/Grape/App/Helpers/Caching.html
* publish with settings
```json
  {
   "direct_name" : "direct_one",
   "routing_key": "routing_key_one",
   "persistent" : true,
    "mandatory":true,
  "type":"type",
  "reply_to": "reply_queue",
  "content_type": "application/json",
  "content_encoding":,
  "priority":1, 
  "message_id": "d7c6718f93b76fe525ee99f5fc7717a0", 
  "correlation_id": "54fecb335af52b7b20b8910a6f1f3edf",
  "app_id": null}
```

* after_send_confirmation
* make publishers a gem
* github actions
* specs
* code generators https://github.com/rails/thor/wiki 

Concepts:
* Isometric::Reconcile
* Isometric::Fetch
  * HTTP Fetch
    * ETag cache
* Isometric::Publish
* Isometric::Listen

What is IPC? Inter process communication
What is sem var? Maj.Min.Patch

What is a partition in kafka
What is AMQP or STOMP
What is Avro or Protocol Buffers
What is the robustness principle?
What are the differences between RPI and HTTP?
What is the REST maturity model?
What is GraphQL and Falcor?
What are disadvantages of REST?

|              | 1 to 1                                         | 1 to M                                        |
|--------------|------------------------------------------------|-----------------------------------------------|
| Synchronous  | Request/Response                               |                                               |
| Asynchronous | 1 way notifications and async request/response | Publish/subscribe and Publish/async responses |


## Patterns

### Remote procedure invocation

### Circuit breaker
A circuit breaker acts as a proxy for operations that might fail. The proxy should monitor the number of recent failures that
have occurred, and use this information to decide whether to allow the operation to proceed, or simply return an exception immediately.

The basic idea behind the circuit breaker is very simple. You wrap a protected function call in a circuit breaker object, 
which monitors for failures. Once the failures reach a certain threshold, the circuit breaker trips, 
and all further calls to the circuit breaker return with an error, without the protected call being made at all. 
Usually you'll also want some kind of monitor alert if the circuit breaker trips.

* Client-side discovery
* Self registration
* Server-side discovery
* Third party registration
* Asynchronous messaging
* Transactional outbox
* Transaction log tailing
* Polling publisher
