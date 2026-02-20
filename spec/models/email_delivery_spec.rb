require "rails_helper"

RSpec.describe EmailDelivery, type: :model do
  it "requires template_key and email" do
    email_delivery = build(:email_delivery, template_key: nil, email: nil)
    expect(email_delivery).not_to be_valid
  end

  it "supports status enum values" do
    expect(described_class.statuses.keys).to eq(%w[queued sent failed bounced])
  end
end
