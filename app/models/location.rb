class Location < ApplicationRecord
  belongs_to :place, polymorphic: true
end
