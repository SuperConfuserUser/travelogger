class Category < ApplicationRecord
  has_many :trip_categories
  has_many :trips, through: :trip_categories
  has_many :category_descriptions

  def formatted_name
    name.capitalize
  end
end
