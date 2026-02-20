require "rails_helper"

RSpec.describe Message, type: :model do
  it "requires a valid sender_type" do
    expect(build(:message, sender_type: "alien")).not_to be_valid
  end

  it "allows sender_type from enum-like list" do
    %w[lead system llm].each do |valid_sender_type|
      expect(build(:message, sender_type: valid_sender_type)).to be_valid
    end
  end
end
