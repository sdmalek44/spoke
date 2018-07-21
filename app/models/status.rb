class Status < ApplicationRecord
  validates_presence_of :bikes_available
  validates_presence_of :docks_available

  belongs_to :station
end
