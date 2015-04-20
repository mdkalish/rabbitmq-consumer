class Currency < ActiveRecord::Base
  validates :uuid, presence: true, uniqueness: true
end
