require 'rails_helper'

RSpec.describe User, type: :model do
  it 'requires a password to create' do
    user = User.new

    user.save

    expect(user.errors[:password].first).to eq("can't be blank")
  end
end
