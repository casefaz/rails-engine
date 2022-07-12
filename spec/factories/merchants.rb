FactoryBot.define do
  factory :merchant do
    name { [Faker::Food.fruits, Faker::IndustrySegments].join(" ") }
  end
end
