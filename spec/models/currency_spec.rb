require 'rails_helper'
require 'publisher'

describe Currency do
  let(:currency) { Currency.new(uuid: 'uuid', rates: 'rates') }
  before { allow(Publisher).to receive(:publish).and_return(currency) }

  context 'when the incoming currency is new' do
    it 'creates new record in db' do
      expect { Currency.save_new_rates } .to change { Currency.count } .from(0).to(1)
    end
  end

  context 'when the incoming currency already exists' do
    let(:existing_currency) { Currency.save_new_rates }

    it 'does not create new record in db' do
      expect(Currency.save_new_rates).to eq(existing_currency)
    end
  end
end
