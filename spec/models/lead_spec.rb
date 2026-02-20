require "rails_helper"

RSpec.describe Lead, type: :model do
  it "is valid with a web property" do
    expect(build(:lead)).to be_valid
  end

  it "requires a web property" do
    expect(build(:lead, web_property: nil)).not_to be_valid
  end
end
