class TripSerializer < ActiveModel::Serializer
  belongs_to :user, serializer: TripUserSerializer
  has_many :categories
  has_many :trip_categories, serializer: TripTripCategorySerializer
  has_many :locations, serializer: TripLocationsExplicitSerializer
  
  attributes :id, :name, :start_date, :end_date, :note, :user_id, :created_at
end
