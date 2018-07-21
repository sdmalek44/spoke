class Station < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :dock_count
  validates_presence_of :city
  validates_presence_of :installation_date

  #this creates a connection to two different foreign keys in the trip table
  #see trips model
  has_many :trips, class_name: 'Trip', foreign_key: :start_station_id
  has_many :trips, class_name: 'Trip', foreign_key: :end_station_id
  has_many :statuses
end
