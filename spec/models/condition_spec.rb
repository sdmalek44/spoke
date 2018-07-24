require 'rails_helper'

describe Condition, type: :model do
  describe 'Validations' do
    it {should validate_presence_of :date}
    it {should validate_presence_of :max_temperature}
    it {should validate_presence_of :mean_temperature}
    it {should validate_presence_of :min_temperature}
    it {should validate_presence_of :mean_humidity}
    it {should validate_presence_of :mean_visibility}
    it {should validate_presence_of :mean_wind_speed}
    it {should validate_presence_of :precipitation}
  end
  describe 'class methods' do
    it ".dates_within_max_temp_range" do
      @condition_1 = Condition.create(date: Date.new(2017, 12, 11), max_temperature: 75.0, mean_temperature: 65.0, min_temperature: 55.0, mean_humidity: 75.0, mean_visibility: 10.0, mean_wind_speed: 11.0, precipitation: 0.23)
      @condition_2 = Condition.create(date: Date.new(2016, 11, 10), max_temperature: 70.0, mean_temperature: 60.0, min_temperature: 50.0, mean_humidity: 65.0, mean_visibility: 5.0, mean_wind_speed: 12.0, precipitation: 0.12)
      @condition_3 = Condition.create(date: Date.new(2016, 1, 1), max_temperature: 81.0, mean_temperature: 66.0, min_temperature: 51.0, mean_humidity: 65.0, mean_visibility: 5.0, mean_wind_speed: 22.0, precipitation: 1.12)
      @condition_4 = Condition.create(date: Date.new(2016, 5, 5), max_temperature: 83.0, mean_temperature: 68.0, min_temperature: 53.0, mean_humidity: 65.0, mean_visibility: 5.0, mean_wind_speed: 33.0, precipitation: 2.12)

      temperature = 70

      dates = Condition.dates_within_max_temp_range(temperature)
      expected_dates = [Date.new(2017, 12, 11), Date.new(2016, 11, 10)]

      expect(dates).to eq(expected_dates)

      temperature = 80

      dates = Condition.dates_within_max_temp_range(temperature)
      expected_dates = [Date.new(2016, 1, 1), Date.new(2016, 5, 5)]

      expect(dates).to eq(expected_dates)
    end
  end
end
