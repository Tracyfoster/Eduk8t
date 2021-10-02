FactoryBot.define do
  factory :course do
    title { "Crytocurrency, The Hard Parts" }
    description { Faker::Lorem.paragraph }
    expertise { "expert" }
    industry { "Finance" }

    factory :invalid_course do
      title { nil }
    end
  end

  factory :user do
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    email { Faker::Internet.unique.email }
    expertise { "expert" }

    factory :invalid_user do
      email { nil }
    end
  end
end
