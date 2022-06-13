require 'rails_helper'

RSpec.describe 'Users', type: :feature do
  it 'goes to users page' do
    visit users_path

    expect(page).to have_text('Users')
  end

  it 'displays all users' do
    FactoryBot.create_list(:user, 10)

    test_user = User.last

    visit users_path

    expect(page).to have_text(test_user.email)
  end
end
