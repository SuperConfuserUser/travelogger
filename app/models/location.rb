class Location < ApplicationRecord
  belongs_to :places, polymorphic: true
end
