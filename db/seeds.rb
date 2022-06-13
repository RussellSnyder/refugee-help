users = FactoryBot.build_list(:user, 10)

users.each(&:save!)
