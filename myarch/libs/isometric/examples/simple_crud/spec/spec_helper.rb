# frozen_string_literal: true

require 'rspec'
require 'rack'
require 'rack/test'
require 'json'
require_relative '../../../lib/isometric'
require_relative '../api/root'

include Rack::Test::Methods

def app
  @app ||= Rack::Builder.parse_file("#{__dir__}/../api/config.ru")
end
