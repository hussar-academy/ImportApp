require 'rails_helper'

RSpec.describe "operations/show", type: :view do
  before(:each) do
    @operation = assign(:operation, Operation.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
