FactoryBot.define do
  factory :item do
    upc { Faker::Alphanumeric.alphanumeric(number: 8) }
    description { Faker::Lorem.word }
    is_exempt { Faker::Boolean.boolean(true_ratio: 0.05) }
    price { Faker::Number.between(from: 0.95, to: 8.95) }
  end
end
