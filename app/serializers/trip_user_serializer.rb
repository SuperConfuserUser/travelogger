class TripUserSerializer < ActiveModel::Serializer
  attributes :username, :image, :tagline, :trips
end
