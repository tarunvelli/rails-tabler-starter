require "rails_helper"

RSpec.describe Space, type: :model do
  it "uses the sites table through compatibility alias" do
    expect(described_class.table_name).to eq("sites")
  end

  it "can be created" do
    expect(build(:space)).to be_valid
  end
end
