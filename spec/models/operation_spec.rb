require 'rails_helper'

RSpec.describe Operation, type: :model do
  subject { create(:operation) }

  it { should belong_to :company }
  it { should have_and_belong_to_many :categories }

  it { should validate_presence_of :invoice_num }
  it { should validate_presence_of :invoice_date }
  it { should validate_presence_of :amount }
  it { should validate_presence_of :operation_date }
  it { should validate_presence_of :kind }
  it { should validate_presence_of :status }

  it { should validate_numericality_of(:amount).is_greater_than(0) }
  it { should validate_uniqueness_of(:invoice_num).case_insensitive }
end
