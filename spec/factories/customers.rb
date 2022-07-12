FactoryBot.define do
  factory :customer do
    first_name { Faker::Food.dish }
    last_name { Faker::Superhero.power }
  end
end
