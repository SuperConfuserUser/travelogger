class Location < ApplicationRecord
  belongs_to :place, polymorphic: true
end

# TODO: probably doesn't need to be polymorphic. I wanted trip and entries to has_many locations, but location can belongs_to trip. entries belongs_to trip and has_many locations through trip. entries can build location off of trip. what relationship should this be then?



