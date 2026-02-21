FactoryBot.define do
  factory :plan do
    name { "Free" }
    price { 0.0 }
    currency { "USD" }
    duration { "monthly" }
    description { {} }

    trait :paid do
      name { "Pro" }
      price { 29.99 }
    end
  end
end
