require 'rails_helper'

describe 'user is logged in' do
  it 'can log out' do
    user = User.create!(username: 'happyharry', email: 'email@email.email', password: 'turtles', first_name: 'hare', last_name: 'margret', address: '1234 dolly st.')

    visit login_path

    fill_in :username, with: user.username
    fill_in :password, with: user.password

    click_button 'Log In'

    expect(current_path).to eq(dashboard_path)

    click_link "Logout"

    expect(page).to have_link("Login")
    expect(page).to_not have_content("Logged in as #{user.username}")
    expect(page).to_not have_link("Logout")
  end
end
