# frozen_string_literal: true

require 'spec_helper'
require 'json'

require_relative '../../listeners/sporting_event/created'
require_relative '../../listeners/sporting_event/deleted'
require_relative '../../listeners/sporting_event/updated'

def listener_af(listener, channel)
  Isometric::EventListenerFactory.instance(channel,
                                           klass: listener,
                                           settings: { after_hooks: [Isometric::RabbitHooks::CLOSE_CHANNEL] }
  )
end

RSpec.describe 'simple flow' do
  let(:params) do
    {
      'internal_id' => '617',
      'name' => 'UFC on ESPN: Vera vs. Cruz',
      'event_date' => 'Aug 13, 2022',
      'venue' => 'Pechanga Arena',
      'location' => 'San Diego, California, U.S.'
    }
  end

  before do
    SportingEvent.delete_all
  end

  describe 'POST /api/sporting_event', type: 'rabbitmq' do
    let(:sporting_event_created_listener) { listener_af(Listener::SportingEvent::Created, 'sporting_event_create') }

    before do
      post('/api/sporting_event', params)
      sporting_event_created_listener.call
    end

    it 'creates 1 event' do
      expect(SportingEvent.count).to eq(1)
    end
  end

  describe 'PUT /api/sporting_event', type: 'rabbitmq' do
    let(:sporting_event_update_listener) { listener_af(Listener::SportingEvent::Updated, 'sporting_event_update') }

    before do
      SportingEvent.create(params)
      put('/api/sporting_event', { 'internal_id' => '617', 'location' => 'Los Angeles, California, U.S.' })
      sporting_event_update_listener.call
    end

    it 'creates 1 event' do
      expect(SportingEvent.last.location).to eq('Los Angeles, California, U.S.')
    end
  end

  describe 'DELETE /api/sporting_event/s/delete', type: 'rabbitmq' do
    let(:sporting_event_delete_listener) { listener_af(Listener::SportingEvent::Deleted, 'sporting_event_delete') }

    before do
      SportingEvent.create(params)
      expect(SportingEvent.count).to eq(1)
      post('/api/sporting_event/617')

      sporting_event_delete_listener.call
    end

    it 'deletes the event' do
      expect(SportingEvent.count).to eq(0)
    end
  end
end
