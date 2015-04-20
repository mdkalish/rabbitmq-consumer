require 'rails_helper'
require 'publisher'

describe Publisher do
  let(:data) { { id: 1, uuid: 'ec2559b2-6b4d-4d40-b4b7-fe3a2217064f' } }

  it 'returns Bunny::Exchange' do
    expect(Publisher.publish(data).class).to eq(Bunny::Exchange)
  end
end
