require 'rails_helper'

RSpec.describe Operation, type: :model do
  subject { build :operation }

  it { is_expected.to belong_to(:company) }
  it { is_expected.to have_many(:category_operations) }
  it { is_expected.to have_many(:categories).through(:category_operations) }

  it { is_expected.to validate_presence_of :invoice_num }
  it { is_expected.to validate_uniqueness_of :invoice_num }

  it { is_expected.to validate_presence_of :amount }
  it { is_expected.to validate_numericality_of(:amount).is_greater_than(0) }

  it { is_expected.to validate_presence_of :invoice_date }
  it { is_expected.to validate_presence_of :operation_date }
  it { is_expected.to validate_presence_of :status }
end
