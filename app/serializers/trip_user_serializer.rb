class TripUserSerializer < ActiveModel::Serializer
  # does it need trip count somehow? has_many :trips or custom method in Trip class
  #may or may not need id. depends on how user link is generate in JS
  attributes :id, :username, :image, :tagline
end
