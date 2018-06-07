class TripCategory < ApplicationRecord
  belongs_to :trip
  belongs_to :category
end
