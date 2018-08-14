class TripCategory < ApplicationRecord
  belongs_to :trip
  belongs_to :category

  def category_name
    self.category.name
  end
end
