require 'faker'

FactoryBot.define do
  factory :example do
    user { association :user }
    phrase { association :phrase }
    example { Faker::Science.element_subcategory }
  end
end
