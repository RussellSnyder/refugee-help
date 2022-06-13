FactoryBot.define do
  factory :user do
    name { Faker::Name.unique.name }
    email { Faker::Internet.unique.email }
    phone_number { Faker::PhoneNumber.phone_number_with_country_code }
    password { 'passwordpassword' }
    role { 'User' }

    factory :admin_user do
      role { 'Admin' }
    end

    factory :super_admin_user do
      role { 'SuperAdmin' }
    end
  end
end
