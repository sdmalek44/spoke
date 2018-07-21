class Trip < ApplicationRecord
  validates_presence_of :duration
  validates_presence_of :start_date
  validates_presence_of :start_station_id
  validates_presence_of :end_date
  validates_presence_of :end_station_id
  validates_presence_of :subscription_type
  validates_presence_of :zip_code

  belongs_to :bike

  #this creates a connection of these 2 foreign keys to the station id in the station table
  #each start and end station id has one associated station
  #see station model
  belongs_to :station, class_name: 'Station', foreign_key: :start_station_id
  belongs_to :station, class_name: 'Station', foreign_key: :end_station_id
end
