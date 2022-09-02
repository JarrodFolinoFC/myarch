require 'avro_turf'
avro = AvroTurf.new(schemas_path: "#{__dir__}/schemas/")
encoded_data = avro.encode({ "first_name" => "Jane", "surname" => 'Doe' }, schema_name: "person")
# puts avro.decode(encoded_data, schema_name: "person")

SCHEMA = {
  "type": "record",
  "name": "User",
  "fields":
    [
    {"name": "name", "type": "string"},
  {"name": "id", "type": "long"},
  {"name": "city", "type": "string"}
]
}.to_json

schema = Avro::Schema.parse(SCHEMA)
dw = Avro::IO::DatumWriter.new(schema)
buffer = StringIO.new
encoder = Avro::IO::BinaryEncoder.new(buffer)
datum = Hash["name" =>'name', "id" => 99999999, "city" => 'city']
 dw.write(datum, encoder)