require "rails_helper"

RSpec.describe WebPropertyLlmConfig, type: :model do
  it "requires unique llm model per web property" do
    web_property = create(:web_property)
    llm_model = create(:llm_model)
    create(:web_property_llm_config, web_property: web_property, llm_model: llm_model)
    duplicate = build(:web_property_llm_config, web_property: web_property, llm_model: llm_model)

    expect(duplicate).not_to be_valid
  end
end
