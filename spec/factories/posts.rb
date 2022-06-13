FactoryBot.define do
  factory :post do
    title { Faker::Name.unique.name }
    user { :user }
    body { Faker::Lorem.paragraph(sentence_count: 6) }
    status { Post::STATUSES.sample }
  end
end
