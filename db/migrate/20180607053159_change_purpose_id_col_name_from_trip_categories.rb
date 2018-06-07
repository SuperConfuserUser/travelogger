class ChangePurposeIdColNameFromTripCategories < ActiveRecord::Migration[5.2]
  def change
    rename_column :trip_categories, :purpose_id, :category_id
  end
end
