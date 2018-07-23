class Station < ApplicationRecord
  extend FriendlyId
  validates_presence_of :name
  validates_presence_of :dock_count
  validates_presence_of :city
  validates_presence_of :installation_date

  has_many :trips, class_name: 'Trip', foreign_key: :start_station_id
  has_many :trips, class_name: 'Trip', foreign_key: :end_station_id
  has_many :statuses

  friendly_id :name, use: :slugged

  def self.total_count
    count
  end
end
