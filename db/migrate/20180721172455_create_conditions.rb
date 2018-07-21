class CreateConditions < ActiveRecord::Migration[5.1]
  def change
    create_table :conditions do |t|
      t.datetime :date
      t.float :max_temperature
      t.float :mean_temperature
      t.float :min_temperature
      t.float :mean_humidity
      t.float :mean_visibility
      t.float :mean_wind_speed
      t.float :precipitation

      t.timestamps
    end
  end
end
