require "rails_helper"

RSpec.describe Site, type: :model do
  it "is valid with a name" do
    expect(build(:site)).to be_valid
  end

  it "is invalid without a name" do
    expect(build(:site, name: nil)).not_to be_valid
  end

  it "returns common and site-scoped roles from all_roles" do
    site = create(:site)
    other_site = create(:site)
    common_role = create(:role, type: Role::COMMON_TYPE, site: nil)
    local_role = create(:role, type: Role::CUSTOM_TYPE, site: site)
    create(:role, type: Role::CUSTOM_TYPE, site: other_site)

    expect(site.all_roles).to include(common_role, local_role)
    expect(site.all_roles.count).to eq(2)
  end
end
