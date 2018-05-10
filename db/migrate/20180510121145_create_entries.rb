class CreateEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :entries do |t|
      t.string :name
      t.text :note
      t.datetime :start_date
      t.datetime :end_date
      t.references :trip, foreign_key: true

      t.timestamps
    end
  end
end
