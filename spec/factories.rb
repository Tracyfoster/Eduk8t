FactoryBot.define do
  factory :user do
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    email { Faker::Internet.unique.email }
    expertise { "advanced" }

    factory :invalid_user do
      email { nil }
    end
  end
end
