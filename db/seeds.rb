users = FactoryBot.build_list(:user, 10)
users.each(&:save!)

users.shuffle.each { |user| FactoryBot.create(:group, user:) }
