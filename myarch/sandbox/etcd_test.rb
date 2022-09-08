require 'etcd'
require 'json'

client = Etcd::Client.connect(uris: ['http://localhost:2379'])
client.connect
client.set('/foo', 'bar')
client.get('/foo')