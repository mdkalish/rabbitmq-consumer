require 'rails_helper'

describe Currency do
  let(:message) { {uuid: 'uuid', rates: 'rates'}.to_json }

  context 'when the incoming currency is new' do
    it 'creates new record in db' do
      expect { Currency.save_new_rates(message) } .to change { Currency.count } .from(0).to(1)
    end
  end

  context 'when the incoming currency already exists' do
    before { Currency.save_new_rates(message) }

    it 'does not create new record in db' do
      expect { Currency.save_new_rates(message) } .not_to change { Currency.count }
    end

    it 'is invalid' do
      expect(Currency.new(uuid: message['uuid'])).to be_invalid
    end
  end
end
