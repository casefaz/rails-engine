FactoryBot.define do
  factory :transaction do
    possible_result = ["success", "failed"]
    invoice
    credit_card_number { "#{Faker::Number.number(digits: 16)}" }
    credit_card_expiration_date { Faker::Date }
    result { possible_result.sample }
  end
end
