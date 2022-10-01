# frozen_string_literal: true

require_relative 'api'
require 'grape-swagger'
require 'grape'

module API
  class Root < Grape::API
    format :json
    mount SimpleCrud::API
    add_swagger_documentation hide_documentation_path: true,
                              api_version: 'v1',
                              info: {
                                title: 'Horses and Hussars',
                                description: 'Demo app for dev of grape swagger 2.0'
                              }
    add_swagger_documentation mount_path: '/tmp/swagger_doc'
  end
end
