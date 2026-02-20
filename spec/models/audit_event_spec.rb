require "rails_helper"

RSpec.describe AuditEvent, type: :model do
  it "requires event_type and occurred_at" do
    event = described_class.new
    expect(event).not_to be_valid
  end

  it "is valid with minimal required attributes" do
    expect(build(:audit_event)).to be_valid
  end
end
