class CreateTripLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :trip_locations do |t|
      t.references :trip, foreign_key: true
      t.references :location, foreign_key: true
    end
  end
end
