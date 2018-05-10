class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.string :name
      t.datetime :start_date
      t.datetime :end_date
      t.text :note
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
