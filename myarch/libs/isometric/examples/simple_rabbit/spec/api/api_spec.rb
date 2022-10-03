# frozen_string_literal: true

require 'spec_helper'
require 'json'

require_relative '../../listeners/sporting_event/created'
require_relative '../../listeners/sporting_event/deleted'
require_relative '../../listeners/sporting_event/updated'

RSpec.describe 'simple flow' do
  let(:sporting_event_created_listener) do
    Isometric::EventListenerFactory.instance('sporting_event_create',
                                             klass: Listener::SportingEvent::Created,
                                             settings: {
                                               after_hooks: [Isometric::RabbitHooks::CLOSE_CHANNEL]
                                             })
  end

  let(:sporting_event_deleted_listener) do
    Isometric::EventListenerFactory.instance('sporting_event_delete',
                                             klass: Listener::SportingEvent::Deleted,
                                             settings: {
                                               after_hooks: [Isometric::RabbitHooks::CLOSE_CHANNEL]
                                             })
  end

  let(:sporting_event_update_listener) do
    Isometric::EventListenerFactory.instance('sporting_event_update',
                                             klass: Listener::SportingEvent::Updated,
                                             settings: {
                                               after_hooks: [Isometric::RabbitHooks::CLOSE_CHANNEL]
                                             })
  end

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

  describe 'POST /api/sporting_event' do
    before do
      post('/api/sporting_event', params)
      sporting_event_created_listener.call
    end

    it 'creates 1 event' do
      expect(SportingEvent.count).to eq(1)
    end
  end

  describe 'PUT /api/sporting_event' do
    before do
      SportingEvent.create(params)
      put('/api/sporting_event', { 'internal_id' => '617', 'location' => 'Los Angeles, California, U.S.' })
      sporting_event_update_listener.call
    end

    it 'creates 1 event' do
      expect(SportingEvent.last.location).to eq('Los Angeles, California, U.S.')
    end
  end

  # describe 'DELETE /api/sporting_event/delete' do
  #   before do
  #     SportingEvent.create(params)
  #     expect(SportingEvent.count).to eq(1)
  #     post('/api/sporting_event/delete/617')
  #     sporting_event_deleted_listener.call
  #   end
  #
  #   it 'deletes the event' do
  #     expect(SportingEvent.count).to eq(0)
  #   end
  # end
end
