require 'rails_helper'

describe Station, type: :model do
  describe 'relationships' do
    it {should have_many :trips}
    it {should have_many :statuses}
  end
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :dock_count}
    it {should validate_presence_of :city}
    it {should validate_presence_of :installation_date}
  end
  describe 'class methods' do
    it 'can get total_count of stations' do
      Station.create!(name: '2name', dock_count: 45, city: 'city', installation_date: Date.new(2017, 3, 10))
      Station.create!(name: '2name', dock_count: 45, city: 'city', installation_date: Date.new(2017, 3, 10))

      expect(Station.total_count).to eq(2)
    end
  end
end
