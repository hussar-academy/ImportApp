require 'rails_helper'

RSpec.describe "operations/edit", type: :view do
  before(:each) do
    @operation = assign(:operation, Operation.create!())
  end

  it "renders the edit operation form" do
    render

    assert_select "form[action=?][method=?]", operation_path(@operation), "post" do
    end
  end
end
