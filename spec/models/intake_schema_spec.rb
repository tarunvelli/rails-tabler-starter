require "rails_helper"

RSpec.describe IntakeSchema, type: :model do
  it "requires unique version per web property" do
    web_property = create(:web_property)
    create(:intake_schema, web_property: web_property, version: 1)
    duplicate = build(:intake_schema, web_property: web_property, version: 1)

    expect(duplicate).not_to be_valid
  end

  it "allows only one active schema per web property" do
    web_property = create(:web_property)
    create(:intake_schema, web_property: web_property, status: :active)
    duplicate_active = build(:intake_schema, web_property: web_property, status: :active)

    expect(duplicate_active).not_to be_valid
    expect(duplicate_active.errors.full_messages.join).to include("only one active schema")
  end
end
