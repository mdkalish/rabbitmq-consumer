require 'publisher'

class Worker
  include Sneakers::Worker
  from_queue "currencies.queue_#{ENV['QUEUE_ID']}", durable: true

  def work(message)
    msg = JSON.parse(message)
    currency = Currency.new(msg)
    if currency.save
      Publisher.publish(id: ENV['QUEUE_ID'], uuid: msg['uuid'])
      ack!
    else
      reject!
    end
  end
end
