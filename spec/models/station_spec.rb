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
end
