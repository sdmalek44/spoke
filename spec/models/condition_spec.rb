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
end
