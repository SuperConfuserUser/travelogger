class AddStartDateToTrips < ActiveRecord::Migration[5.2]
  def change
    add_column :trips, :start_date, :date_time
  end
end
