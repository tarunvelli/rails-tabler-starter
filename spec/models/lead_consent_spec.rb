require "rails_helper"

RSpec.describe LeadConsent, type: :model do
  it "requires consent_type" do
    expect(build(:lead_consent, consent_type: nil)).not_to be_valid
  end

  it "is valid without lead_session" do
    expect(build(:lead_consent, lead_session: nil)).to be_valid
  end
end
