require 'rails_helper'

describe User, type: :model do
  describe 'Validations' do
    it {should validate_presence_of :password}
    it {should validate_presence_of :email}
    it {should validate_uniqueness_of :username}
    it {should validate_uniqueness_of :email}
    it {should have_secure_password}
  end
  describe 'Relationships' do
    it {should have_many :orders}
  end
end
