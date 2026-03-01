FactoryBot.define do
  factory :space do
    sequence(:name) { |n| "Test Space #{n}" }
    status { :active }

    trait :archived do
      status { :archived }
    end
  end
end
