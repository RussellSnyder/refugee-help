FactoryBot.define do
  factory :group do
    name { Faker::Name.unique.name }
    location { Faker::Name.unique.name }
    about { Faker::Lorem.paragraph(sentence_count: 4) }
    user { :user }
  end
end
