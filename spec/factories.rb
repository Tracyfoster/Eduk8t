FactoryBot.define do
  factory :author do
    name { Faker::Name.name }
    title { "VP Growth and Development" }
    company_name { Faker::Company.name }
    bio { Faker::Lorem.paragraph }

    factory :invalid_author do
      name { nil }
    end
  end

  factory :course do
    title { "Crytocurrency, The Hard Parts" }
    description { Faker::Lorem.paragraph }
    expertise { "expert" }
    industry { "Finance" }
    author

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
