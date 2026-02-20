require "rails_helper"

RSpec.describe UserRole, type: :model do
  it "is valid for a common role regardless of site" do
    common_role = create(:role, type: Role::COMMON_TYPE, site: nil)
    user_role = build(:user_role, role: common_role)

    expect(user_role).to be_valid
  end

  it "is invalid when a custom role belongs to another site" do
    site = create(:site)
    other_site = create(:site)
    custom_role = create(:role, type: Role::CUSTOM_TYPE, site: other_site)
    user_role = build(:user_role, site: site, role: custom_role)

    expect(user_role).not_to be_valid
    expect(user_role.errors.full_messages.join).to include("invalid role for site")
  end
end
