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

  context 'import from csv file' do
    before(:each) do
      load "#{Rails.root}/db/seeds.rb"
    end

    def import_csv
      Operation.import(Rails.root.join('spec/support/fixtures/small_example.csv'))
    end

    it 'creates new categories' do
      expect { import_csv }.to change(Category, :count).by(6)
    end

    it 'creates operations only with existing companies' do
      expect { import_csv }.to change(Operation, :count).by(4)
    end

    it 'updates existing operations' do
      company = Company.find_by(name: 'BP Biznes')
      operation = create(:operation, company: company, invoice_num: 'B3963', amount: 1000)

      import_csv
      operation.reload
      expect(operation.amount).to eq(10862.48)
    end

    it 'not creates new companies' do
      expect { import_csv }.to_not change(Company, :count)
    end

    it 'correct parse dates' do
      import_csv

      expect(Operation.find_by(invoice_num: 'B3963').invoice_date).to eq(Date.new(2014, 10, 19))
      expect(Operation.find_by(invoice_num: 'B15428').invoice_date).to eq(Date.new(2014, 12, 7))
      expect(Operation.find_by(invoice_num: 'O61568').invoice_date).to eq(Date.new(2014, 2, 9))
    end
  end
end
