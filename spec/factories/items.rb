FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::Coffee.notes }
    unit_price { (Faker::Number.between(2.5..500.0)).round(2) }
    merchant
  end
end
