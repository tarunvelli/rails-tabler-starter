require "rails_helper"

RSpec.describe WebProperty, type: :model do
  it "is valid with required attributes" do
    expect(build(:web_property)).to be_valid
  end

  it "requires public_id" do
    expect(build(:web_property, public_id: nil)).not_to be_valid
  end
end
