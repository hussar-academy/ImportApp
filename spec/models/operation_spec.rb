require 'rails_helper'

RSpec.describe Operation, type: :model do
  let(:operation)
  it "is valid with valid attributes" do
    expect(Operation.new).to be_valid
  end
  
  it "is not valid without an invoice number"
  it "is not valid without an invoice date"
  it "is not valid without an amount"
  it "is not valid without an operation date"
  it "is not valid without a kind"
  it "is not valid without a status"

  it "should validate numericality of amount"
  it "should validate uniqueness of invoice_num"
end
