require 'rails_helper'
require 'currency_worker'

describe CurrencyWorker do
  let(:worker) { CurrencyWorker.new }

  context 'when message is valid' do
    let(:message) { {uuid: 'uuid', 'rates': {'AED':3.6, 'PLN': 3.7}}.to_json }
    after { Currency.destroy_all }

    it 'uses publisher to send ack message' do
      expect(Publisher).to receive(:publish)
      worker.work(message)
    end

    it 'returns ack' do
      expect(worker.work(message)).to eq(:ack)
    end
  end

  context 'when message is invalid' do
    let(:invalid_message) { {id: 1, uuid: ''}.to_json }

    it 'sends reject' do
      expect(worker.work(invalid_message)).to eq(:reject)
    end
  end
end
