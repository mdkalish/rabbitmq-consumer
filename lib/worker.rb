require 'publisher'

class Worker
  include Sneakers::Worker
  from_queue "currencies.queue_#{ENV['QUEUE_ID']}", durable: true

  def work(message)
    msg = JSON.parse(message)
    if Currency.save_new_rates(msg)
      Publisher.publish(id: ENV['QUEUE_ID'], uuid: msg['uuid'])
      ack!
    elsif try_count_by_consumer <= 5
      requeue!
    else
      Rails.cache.clear('try_count_by_consumer')
      reject!
    end
  end

  def try_count_by_consumer
    if Rails.cache.read('try_count_by_consumer').blank?
      Rails.cache.write('try_count_by_consumer', 1)
      1
    else
      Rails.cache.increment('try_count_by_consumer')
    end
  end
end
