class TripUserSerializer < ActiveModel::Serializer
  attributes :username, :image, :tagline, :trip_count
end
