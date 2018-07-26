require 'rails_helper'

describe "'when user visits the '/' page" do
  it 'they can click to login' do
    visit root_path

    click_link "Login"

    expect(current_path).to eq(login_path)
  end
  it 'can log in if already have an account' do
    user = User.create!(username: 'happyharry', email: 'email@email.email', password: 'turtles')
    visit login_path

    fill_in :username, with: user.username
    fill_in :password, with: user.password

    click_button 'Log In'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Logged in as #{user.username}")
    expect(page).to have_link("Logout")
    expect(page).to_not have_link("Login")
  end
  it 'renders login page again if incorrect username/password' do
    user = User.create!(username: 'happyharry', email: 'email@email.email', password: 'turtles')
    visit login_path

    fill_in :username, with: "lsldkj"
    fill_in :password, with: user.password

    click_button 'Log In'

    expect(current_path).to eq(login_path)
    expect(page).to have_content("Incorrect login information. Please try again.")
  end
end
