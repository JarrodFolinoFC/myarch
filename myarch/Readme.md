What is a partition in kafka
What is AMQP or STOMP
What is Avro or Protocol Buffers
What is IPC? Inter process communication
What is the robustness principle?
What is sem var?
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
