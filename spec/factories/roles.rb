FactoryBot.define do
  factory :role do
    sequence(:name) { |n| "Role #{n}" }
    permissions { {} }
    type { "common" }

    trait :common do
      type { "common" }
      name { "admin" }
      permissions { { "create_user" => "true", "read_user" => "true", "update_user" => "true", "delete_user" => "true" } }
    end

    trait :custom do
      type { "custom" }
      name { "member" }
      permissions { { "read_user" => "true" } }
    end
  end
end
