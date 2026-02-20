require "rails_helper"

RSpec.describe LeadSession, type: :model do
  it "is valid with matching lead, web property, and schema" do
    expect(build(:lead_session)).to be_valid
  end

  it "requires unique session token" do
    create(:lead_session, session_token: "duplicate-token")
    duplicate = build(:lead_session, session_token: "duplicate-token")

    expect(duplicate).not_to be_valid
  end

  it "rejects mismatched web_property across related records" do
    lead = create(:lead)
    different_web_property = create(:web_property)
    intake_schema = create(:intake_schema, web_property: different_web_property)
    lead_session = build(:lead_session, lead: lead, web_property: lead.web_property, intake_schema: intake_schema)

    expect(lead_session).not_to be_valid
    expect(lead_session.errors.full_messages.join).to include("must match intake_schema.web_property_id")
  end
end
