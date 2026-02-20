require "rails_helper"

RSpec.describe Role, type: :model do
  it "is valid with allowed permission keys and values" do
    role = build(:role, permissions: { "read_user" => "true", "update_site" => "false" })
    expect(role).to be_valid
  end

  it "is invalid with unknown permission key" do
    role = build(:role, permissions: { "launch_nukes" => "true" })
    expect(role).not_to be_valid
  end

  it "is invalid with unknown permission value" do
    role = build(:role, permissions: { "read_user" => "maybe" })
    expect(role).not_to be_valid
  end
end
