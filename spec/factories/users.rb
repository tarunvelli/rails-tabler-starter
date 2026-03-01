FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "password123" }
    first_name { "John" }
    last_name { "Doe" }
    status { :active }

    trait :admin do
      admin { true }
    end

    trait :archived do
      status { :archived }
    end

    trait :confirmed do
      confirmed_at { Time.current }
    end
  end
end
