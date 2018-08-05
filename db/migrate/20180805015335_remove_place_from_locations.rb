class RemovePlaceFromLocations < ActiveRecord::Migration[5.2]
  def change
    remove_column :locations, :place_id
    remove_column :locations, :place_type
    remove_column :locations, :index
  end
end
