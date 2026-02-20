FactoryBot.define do
  factory :site do
    sequence(:name) { |n| "Site #{n}" }
    status { 0 }

    factory :space, class: "Space"
  end
end
