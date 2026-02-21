FactoryBot.define do
  factory :subscription do
    association :space
    association :plan
    start_date { Date.current }
    seats { 5 }

    trait :active do
      end_date { nil }
    end

    trait :expired do
      end_date { 1.day.ago }
    end
  end
end
