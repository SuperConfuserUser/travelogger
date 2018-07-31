class AddDescriptionToTripCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :trip_categories, :description, :string
  end
end
