require 'rails_helper'

describe 'user can go to station show page' do
  it 'can see all attributes' do
    station = Station.create!(name: 'name', dock_count: 45, city: 'city', installation_date: Date.new(2017, 3, 10))

    visit station_path(station)

    expect(page).to have_content(station.name)
    expect(page).to have_content(station.dock_count)
    expect(page).to have_content(station.city)
    expect(page).to have_content(station.installation_date)
  end
end
