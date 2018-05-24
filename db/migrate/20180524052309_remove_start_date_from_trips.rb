class RemoveStartDateFromTrips < ActiveRecord::Migration[5.2]
  def change
    remove_column :trips, :start_date, :string
  end
end
