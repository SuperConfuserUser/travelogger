class Category < ApplicationRecord
  has_many :trip_categories
  has_many :trips, through: :trip_categories

  def formatted_name
    name.capitalize
  end

  scope :business, -> { where(name: 'business') }
end
