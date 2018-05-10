class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.string :name
      t.integer :place_id
      t.integer :place_type

      t.timestamps
    end

    add_index :locations, [:place_type, :place_id]
  end
end
