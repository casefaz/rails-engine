# frozen_string_literal: true

FactoryBot.define do
  factory :invoice_item do
    item
    invoice
    quantity { 23 }
    unit_price { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
  end
end
