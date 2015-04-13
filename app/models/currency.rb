class Currency < ActiveRecord::Base
  validates :uuid, presence: true, uniqueness: true

  def self.save_new_rates(message)
    if Currency.new(uuid: message['uuid']).invalid?
      false
    else
      Currency.create_with(rates: message['rates'])
        .find_or_create_by!(uuid: message['uuid'])
    end
  end
end
