require 'rails_helper'

RSpec.describe User, type: :model do
  it 'requires a password to create' do
    user = User.new

    user.save

    expect(user.errors[:password].first).to eq("can't be blank")
  end

  describe 'Roles' do
    it 'a non-admin user cannot change another users role' do
      user1 = FactoryBot.create(:user)
      group = FactoryBot.create(:group, user: user1)
      user1.admin_for_groups << group

      user2 = FactoryBot.create(:user)

      user1.upgrade_user_to_admin_of_group(user2.id, group.id)

      expect(user2.role).to eq('User')
    end

    it 'a super admin can set a user to the role of admin' do
      super_admin_user = FactoryBot.create(:super_admin_user)

      random_user = FactoryBot.create(:user)
      group = FactoryBot.create(:group, user: random_user)

      user2 = FactoryBot.create(:user)

      super_admin_user.upgrade_user_to_admin_of_group(user2.id, group.id)

      updated_user = User.find(user2.id)

      expect(super_admin_user.errors).to match_array([])
      expect(updated_user.role).to eq('Admin')
      expect(updated_user.admin_for_groups[0].id).to eq(group.id)
    end

    it 'a super admin can set a user to the role of super admin' do
      user = create(:user)
      super_admin = create(:super_admin_user)

      super_admin.upgrade_user_to_super_admin(user.id)

      updated_user = User.find(user.id)

      expect(super_admin.errors).to match_array([])

      expect(updated_user.role).to eq('SuperAdmin')
    end
    it 'a user cannot set a user to the role of super admin' do
      user1 = create(:user)
      user2 = create(:user)

      user1.upgrade_user_to_super_admin(user2.id)

      expect(user1.errors).not_to match_array([])
      expect(user2.role).to eq('User')
    end

    it 'an admin cannot set a user to the role of super admin' do
      user = create(:user)
      admin = create(:admin_user)

      admin.upgrade_user_to_super_admin(user)

      expect(user.role).to eq('User')
    end
  end

  describe 'Group Admins' do
    it 'an admin can set a user to the role of admin of a group they are an admin of'

    it 'a super admin can set a user to be the admin of a group'

    it 'a super admin can set a user to be the admin of several groups'
  end

  describe 'Posts' do
    it 'deletes a users posts if the user is destroyed'
  end

  it 'can set other users to admin user is superadmin'
  it 'can add other users as admin to a group if '

  describe 'Group' do
    describe 'Belongs to Admin' do
      it 'can set another user as the main user of a group'
    end
    describe "Doesn't Belong to User" do
      it 'can not set another user as the main user of a group'
      it 'if admin, can not set another user as the main user of a group if user is not main user of group'
    end
  end
end
