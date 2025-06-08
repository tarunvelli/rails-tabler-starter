require 'rails_helper'

RSpec.describe "spaces/index", type: :view do
  before(:each) do
    assign(:spaces, [
      Space.create!(
        name: "Name",
        status: "Status"
      ),
      Space.create!(
        name: "Name",
        status: "Status"
      )
    ])
  end

  it "renders a list of spaces" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Status".to_s), count: 2
  end
end
