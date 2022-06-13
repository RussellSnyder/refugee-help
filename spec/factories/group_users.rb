FactoryBot.define do
  factory :group_user do
    group { :group }
    user { :user }
  end
end
