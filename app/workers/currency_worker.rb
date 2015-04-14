class CurrencyWorker
  include Sneakers::Worker
  from_queue "currencies.queue_#{ENV['QUEUE_ID']}",
    WORKER_OPTIONS.merge({
                          :arguments => {
                            :'x-dead-letter-exchange' => "currencies.queue_#{ENV['QUEUE_ID']}-retry"
                          },
                        })

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
