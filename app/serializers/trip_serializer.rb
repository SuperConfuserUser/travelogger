class TripSerializer < ActiveModel::Serializer
  belongs_to :user
  has_many :categories
  has_many :trip_categories
  has_many :locations
  
  attributes :id, :name, :start_date, :end_date, :note, :user_id
end
