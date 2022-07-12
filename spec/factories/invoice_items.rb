FactoryBot.define do
  factory :invoice_item do
    item
    invoice 
    quantity { Faker::Number.between(1..52) }
    unit_price { Faker::Number.between(2.5..500.0) }.round(2)
  end
end
