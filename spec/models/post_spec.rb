require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'destroys posts is user is destroyed' do
    user = create(:user)

    create_list(:post, 3, user:)

    expect(Post.all.count).to eq(3)
    expect(Post.last.user_id).to eq(user.id)

    user.destroy!

    expect(Post.all.count).to eq(0)
  end
end
