require 'rails_helper'

describe 'when admin user visits /' do
  before(:each) do
    @user = User.create!(username: 'happyharry', email: 'email@email.email', password: 'turtles')
    @admin = User.create!(username: 'bob', email: 'bob@email.email', password: 'bob', role: 1)
  end
  it 'can login as admin and see dashboard' do
    visit root_path

    click_on 'Login'

    fill_in :username, with: 'bob'
    fill_in :password, with: 'bob'
    click_on 'Log In'

    expect(current_path).to eq(admin_dashboard_path)
    expect(page).to have_content("Logged in as Admin User: bob")

  end
end
