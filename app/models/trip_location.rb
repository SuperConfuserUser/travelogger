class TripLocation < ApplicationRecord
  belongs_to :trip
  belongs_to :location
end
