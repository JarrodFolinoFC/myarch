require_relative 'bunny_connection_factory'

module Messageable
  attr_reader :conn, :channel
  def msg_connect!
    @conn = BunnyConnectionFactor.get_bunny
    @conn.start
    @channel = @conn.create_channel
  end
end