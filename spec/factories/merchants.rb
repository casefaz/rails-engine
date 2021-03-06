# frozen_string_literal: true

FactoryBot.define do
  factory :merchant do
    name { [Faker::Food.fruits, Faker::IndustrySegments.industry].join(' ') }
  end
end
