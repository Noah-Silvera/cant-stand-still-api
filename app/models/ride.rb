class Ride < ApplicationRecord
  belongs_to :rider
  belongs_to :trip, optional: true
end
