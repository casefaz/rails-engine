# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    possible_result = %w[success failed]
    invoice
    credit_card_number { Faker::Number.number(digits: 16).to_s }
    credit_card_expiration_date { Faker::Date }
    result { possible_result.sample }
  end
end
