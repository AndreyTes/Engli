require 'faker'

FactoryBot.define do
  factory :phrase do
    user { association :user }
    phrase { Faker::Science.element }
    translation { Faker::Science.element_symbol }
    category {"Actions"}
  end
end