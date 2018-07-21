require 'rails_helper'

describe 'when user visits /login page' do
  it 'can create a new account' do
    visit login_path

    click_link "Create Account"

    expect(current_path).to eq(new_user_path)
    username = 'happyharry'

    fill_in :user_email, with: 'email@email.email'
    fill_in :user_username, with: username
    fill_in :user_password, with: 'turtles'

    click_button "Create Account"

    expect(current_path).to eq(dashboard_index_path)
  end
  it 'can log in if already have an account' do
    user = User.create!(username: 'happyharry', email: 'email@email.email', password: 'turtles')
    visit login_path

    fill_in :username, with: user.username
    fill_in :password, with: user.password

    click_button 'Log In'

    expect(current_path).to eq(dashboard_index_path)
    expect(page).to have_content("Logged in as #{username}")
    expect(page).to have_link("Logout")
    expect(page).to_not have_link("Login")
  end
end
