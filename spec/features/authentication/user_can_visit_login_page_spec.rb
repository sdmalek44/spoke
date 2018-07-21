require 'rails_helper'

describe "'when user visits the '/' page" do
  it 'they can click to login' do
    visit root_path

    click_link "Login"

    expect(current_path).to eq(login_path)
  end
end
