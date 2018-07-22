require 'rails_helper'

describe Status, type: :model do
  describe 'Validations' do
    it {should validate_presence_of :bikes_available}
    it {should validate_presence_of :docks_available}
  end
  describe 'Relationships' do
    it {should belong_to :station}
  end
end
