class Location < ApplicationRecord
  belongs_to :place, polymorphic: true
end

# TODO: probably doesn't need to be polymorphic. i wanted trip and entries to own a location, but location can belong to trip. entries has location through location. entries can build location off of trip


