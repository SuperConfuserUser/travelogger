class TripCategorySerializer < ActiveModel::Serializer
  belongs_to :trip
  belongs_to :category
  
  attributes :id, :trip_id, :category_id, :description
end
