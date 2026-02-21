FactoryBot.define do
  factory :user_role do
    association :user
    association :space
    association :role
  end
end
