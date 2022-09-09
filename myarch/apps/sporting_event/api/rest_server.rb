require 'sinatra'

require_relative '../db/db_connection'
require_relative '../models/sporting_event'
require_relative '../../../libs/ruby/discovery/registry'


DbConnection.connect!
Heart::Core::Discovery::Registry.new.set('app/sporting_event_rest_server', "http://localhost:4567")

get '/sporting_events' do
  content_type :json
  SportingEvent.all.to_json
end

get '/sporting_events/:internal_id' do
  content_type :json
  SportingEvent.where(intenal_id: params['internal_id']).to_json
end