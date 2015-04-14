class Publisher
  def self.publish(data)
    exchange.publish(data.to_json, persistent: true)
  end

  private

  def self.connection
    @connection ||= Bunny.new.tap { |c| c.start }
  end

  def self.channel
    @channel ||= connection.create_channel
  end

  def self.exchange
    channel.direct('currencies.direct', routing_key: 'acknowledgements')
  end
end
