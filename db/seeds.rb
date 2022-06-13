users = FactoryBot.build_list(:user, 50)
admin_users = FactoryBot.build_list(:admin_user, 10)
super_admin_users = FactoryBot.build_list(:super_admin_user, 5)

(users + admin_users + super_admin_users).each(&:save!)

puts "#{users.count} users seeded"

groups = FactoryBot.build_list(:group, 10, user: users.sample)
groups << FactoryBot.build(:group, name: 'Herzogenauruch', user: users.sample)
groups.each(&:save!)

puts "#{groups.count} groups seeded"

posts = FactoryBot.build_list(:post, 100, user: users.sample)
posts.each(&:save!)

puts "#{posts.count} posts seeded"

posts.sample(Faker::Number.between(from: 1, to: posts.count)).each do |post|
  associated_groups = groups.shuffle.sample(Faker::Number.between(from: 1, to: groups.count))

  post.groups = associated_groups

  post.save!
end

puts "#{GroupPost.all.count} GroupPost associations seeded"

admin_users.each do |user|
  associated_groups = groups.shuffle.sample(Faker::Number.between(from: 1, to: groups.count))

  user.admin_for_groups = associated_groups

  user.save!
end

puts "#{GroupAdmin.all.count} GroupAdmin associations seeded"
