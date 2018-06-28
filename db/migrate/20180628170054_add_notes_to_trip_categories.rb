class AddNoteToTripCategories < ActiveRecord::Migration[5.2]
  def up
    add_column :trip_categories, :note, :text
  end

  def down 
    remove_column :trip_categories, :note, :text
  end
end
