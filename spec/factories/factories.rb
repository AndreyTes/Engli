require 'faker'

FactoryBot.define do

  factory :user do
    email { Faker::Internet.email }
    username { Faker::Internet.user_name }
    password {"password"}
    password_confirmation {"password"}
  end

  factory :phrase do
    user { association :user }
    phrase { Faker::Science.element }
    translation { Faker::Science.element_symbol }
    category {"Actions"}
  end

  factory :example do
    user { association :user }
    phrase { association :phrase }
    example { Faker::Science.element_subcategory }
  end

end
