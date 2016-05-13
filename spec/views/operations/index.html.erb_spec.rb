require 'rails_helper'

RSpec.describe "operations/index", type: :view do
  before(:each) do
    assign(:operations, [
      Operation.create!(),
      Operation.create!()
    ])
  end

  it "renders a list of operations" do
    render
  end
end
