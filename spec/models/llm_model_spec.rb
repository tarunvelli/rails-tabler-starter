require "rails_helper"

RSpec.describe LlmModel, type: :model do
  it "requires provider and model_id" do
    model = described_class.new
    expect(model).not_to be_valid
  end

  it "enforces one active model at a time" do
    create(:llm_model, active: true)
    another_active = build(:llm_model, active: true)

    expect(another_active).not_to be_valid
    expect(another_active.errors.full_messages.join).to include("only one active model")
  end
end
