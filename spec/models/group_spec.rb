require 'rails_helper'

RSpec.describe Group, type: :model do
  it 'main_contact' do
    user = FactoryBot.create(:user)
    group = FactoryBot.create(:group, user:)

    expect(group.main_contact).to eq(user)
  end
end
