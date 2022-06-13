users = FactoryBot.build_list(:user, 10)
users.each(&:save!)

puts "#{users.count} users seeded"

groups = FactoryBot.build_list(:group, 10, user: users.sample)
groups << FactoryBot.build(:group, name: 'Herzogenauruch', user: users.sample)
groups.each(&:save!)

puts "#{groups.count} groups seeded"

posts = FactoryBot.build_list(:post, 100, user: users.sample)
posts.each(&:save!)

puts "#{posts.count} posts seeded"

associated_groups_count = 0

posts.sample(Faker::Number.between(from: 1, to: posts.count)).each do |post|
  associated_groups = groups.shuffle.sample(Faker::Number.between(from: 1, to: groups.count))

  post.groups = associated_groups

  post.save!

  associated_groups_count += associated_groups.size
end

puts "#{associated_groups_count} group post associations seeded"
