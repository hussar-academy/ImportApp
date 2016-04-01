require 'date_converter'

class Operation < ActiveRecord::Base
  belongs_to :company
  has_and_belongs_to_many :categories

  validates :invoice_num, :invoice_date, :amount, :operation_date, :kind, :status, presence: :true
  validates :amount, numericality: {greater_than: 0}
  validates :invoice_num, uniqueness: true

  def self.import(csv_file)
    rows = SmarterCSV.process(csv_file, {value_converters: {invoice_date: DateConverter, operation_date: DateConverter}})

    rows.each do |row|
      company = Company.find_by(name: row[:company])
      next unless company

      categories = Category.find_or_create_by_array(row[:kind].split(';'))
      params = row.merge({company: company, categories: categories})

      operation = Operation.find_by(company: company, invoice_num: row[:invoice_num]) || new
      operation.update_attributes(params)
      operation.save
    end
  end
end
