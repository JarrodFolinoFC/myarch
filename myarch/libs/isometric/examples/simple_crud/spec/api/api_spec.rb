require 'spec_helper'
require 'json'

require_relative '../../listeners/sporting_event/created'

RSpec.describe 'simple flow' do
  let(:sporting_event_created_listener) {
    Isometric::EventListenerFactory.instance('sporting_event_create',
      klass: Listener::SportingEvent::Created,
      settings: {
        after_hooks: [Isometric::RabbitHooks::CLOSE_CHANNEL]
      }
    )
  }

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

  describe '/api/sporting_event' do
    before do
      post('/api/sporting_event', params)
      sporting_event_created_listener.call
    end

    it 'creates 1 event' do
      expect(SportingEvent.count).to eq(1)
    end
  end
end