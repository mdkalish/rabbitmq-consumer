class Currency < ActiveRecord::Base

  private

  def self.save_new_rates
    message = Publisher.publish
    Currency.create_with(rates: message[:rates])
      .find_or_create_by!(uuid: message[:uuid])
  end
end
