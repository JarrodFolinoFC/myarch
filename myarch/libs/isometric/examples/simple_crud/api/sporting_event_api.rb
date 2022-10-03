# frozen_string_literal: true

require 'active_record'
require 'grape-swagger'
require 'grape'

require_relative '../../../lib/isometric'

require_relative '../config/db'
require_relative '../config/bunny'
require_relative '../config/rabbit_cluster'
require_relative '../config/about'
require_relative '../config/default_publish_attributes'
require_relative '../config/logger'
require_relative '../models/sporting_event'

Isometric::DbConnection.connect!
Isometric::RegistryFactory.instance.set('app/sporting_event_rest_server', 'http://localhost:4567')

module API
  class SportingEvent < Grape::API
    version 'v1', using: :header, vendor: 'acme'
    format :json
    prefix :api

    desc 'Return all sporting events.'
    get :sporting_events do
      SportingEvent.limit(20)
    end

    resource :sporting_event do
      desc 'Return a sporting event.'
      params do
        requires :internal_id, type: Integer, desc: 'Status ID.'
      end
      route_param :internal_id do
        get do
          SportingEvent.find_by(internal_id: params[:internal_id])
        end
      end

      desc 'Create a sporting event.'
      params do
        requires :internal_id, type: String, desc: 'Your status.'
        requires :name, type: String, desc: 'Your status.'
        requires :event_date, type: String, desc: 'Your status.'
        requires :venue, type: String, desc: 'Your status.'
        requires :location, type: String, desc: 'Your status.'
      end
      post do
        corr_id = ::Isometric::PublisherFactory.instance('sporting_event_create').publish do
          {
            internal_id: params[:internal_id], name: params[:name],
            event_date: params[:event_date], venue: params[:venue],
            location: params[:location]
          }.to_json
        end
        { correlation_id: corr_id }
      end

      desc 'Update a sporting event.'
      params do
        requires :internal_id, type: String, desc: 'Your status.'
        requires :name, type: String, desc: 'Your status.'
        requires :event_date, type: String, desc: 'Your status.'
        requires :venue, type: String, desc: 'Your status.'
        requires :location, type: String, desc: 'Your status.'
      end
      put do
        corr_id = Isometric::OutboxPublisherFactory.instance('sporting_event_update').publish do
          {
            internal_id: params[:internal_id], name: params[:name],
            event_date: params[:event_date], venue: params[:venue],
            location: params[:location]
          }
        end
        { correlation_id: corr_id }
      end

      desc 'Delete a sporting event.'
      params do
        requires :internal_id, type: String, desc: 'Your status.'
      end
      delete ':id' do
        corr_id = Isometric::OutboxPublisherFactory.instance('sporting_event_delete').publish do
          {
            internal_id: params[:internal_id]
          }
        end
        { correlation_id: corr_id }
      end
    end
  end
end
