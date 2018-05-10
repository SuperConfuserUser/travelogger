class CreateTripCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :trip_categories do |t|
      t.references :trip, foreign_key: true
      t.references :purpose, foreign_key: true

      t.timestamps
    end
  end
end
