require 'rails_helper'

describe "A visitor visits '/stations'" do
  it 'they see all stations and all station attributes' do
    station_1 = Station.create!(name: 'Test Station 1', dock_count: 20, city: 'Chicago', installation_date: Date.new(2018, 6, 21))
    station_2 = Station.create!(name: 'Test Station 2', dock_count: 25, city: 'Denver', installation_date: Date.new(2017, 6, 21))
    station_3 = Station.create!(name: 'Test Station 3', dock_count: 30, city: 'Dallas', installation_date: Date.new(2016, 6, 21))

    visit stations_path

    expect(page).to have_content("#{station_1.name}")
    expect(page).to have_content("Dock Count: #{station_1.dock_count}")
    expect(page).to have_content("City: #{station_1.city}")
    expect(page).to have_content("Installation Date: #{station_1.installation_date.strftime('%m/%d/%Y')}")
    expect(page).to have_content("#{station_2.name}")
    expect(page).to have_content("Dock Count: #{station_2.dock_count}")
    expect(page).to have_content("City: #{station_2.city}")
    expect(page).to have_content("Installation Date: #{station_2.installation_date.strftime('%m/%d/%Y')}")
    expect(page).to have_content("#{station_3.name}")
    expect(page).to have_content("Dock Count: #{station_3.dock_count}")
    expect(page).to have_content("City: #{station_3.city}")
    expect(page).to have_content("Installation Date: #{station_3.installation_date.strftime('%m/%d/%Y')}")
  end
end
