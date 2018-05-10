class TripCategory < ApplicationRecord
  belongs_to :trip
  belongs_to :purpose
end
