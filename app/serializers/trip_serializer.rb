class TripSerializer < ActiveModel::Serializer
  belongs_to :user
  has_many :trip_categories
  has_many :categories, through: :trip_categories
  has_many :entries
  has_many :locations, as: :place
  
  attributes :id, :name, :start_date, :end_date, :note, :user_id
end
