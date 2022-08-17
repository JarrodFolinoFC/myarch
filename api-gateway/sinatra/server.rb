require 'sinatra'
require_relative 'middleware/simple_proxy'
require_relative 'middleware/logger_middleware'

use  LoggerMiddleware
use  SimpleProxy, {ssl_verify_none: true}


get '/hello' do
  'Hello World'
end