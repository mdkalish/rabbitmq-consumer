require 'rails_helper'
require 'worker'

describe Worker do
  let(:worker) { Worker.new }

  context 'when message is valid' do
    let(:worker) { Worker.new }
    let(:message) { {uuid: 'uuid', rates: 'rates'}.to_json }
    after { Currency.destroy_all }

    it 'uses publisher to send ack' do
      Publisher = spy('Publisher')
      worker.work(message)
      expect(Publisher).to have_received(:publish)
    end

    it 'returns ack' do
    end
  end

  context 'when message is invalid' do
    let(:invalid_message) { {id: 1, uuid: ''}.to_json }
    before { 4.times { worker.work(invalid_message) } }
    after { Rails.cache.clear('try_count_by_consumer') }

    it 'requeues up to 5 times' do
      expect(worker.work(invalid_message)).to eq(:requeue)
    end

    it 'rejects the query after 5 requeues' do
      worker.work(invalid_message)
      expect(worker.work(invalid_message)).to eq(:reject)
    end
  end
end
