class CreateTrips < ActiveRecord::Migration[5.1]
  def change
    create_table :trips do |t|
      t.integer :duration
      t.datetime :start_date
      t.integer :start_station_id
      t.datetime :end_date
      t.integer :end_station_id
      t.integer :bike_id
      t.integer :subscription_type, default: 0
      t.integer :zip_code

      t.timestamps
    end
  end
end
