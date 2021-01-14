FactoryBot.define do
  factory :member do
    name { Faker::Name.name }
    phone { Faker::PhoneNumber.phone_number }
    discount { Faker::Number.between(from: 0.01, to: 0.03) }
  end
end
