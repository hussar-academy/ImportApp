require 'csv'

class CsvImporter < BaseService

  CSV_PARSER_OPTIONS = {
    headers: true
  }.freeze

  HEADERS = %w(invoice_num invoice_date operation_date amount reporter
    notes status).freeze

  def call
    process_file
  end

  def initialize(file)
    self.file = file
    self.operations = []
    self.successes = 0

    self.companies = load_table(Company)
    self.categories = load_table(Category)
  end

  attr_accessor :successes, :operations

  private

  attr_accessor :file, :companies, :categories

  def load_table(model)
    records = {}
    model.find_each { |m| records[m.name] = m }
    records
  end

  def process_file
    counter = 0
    CSV.foreach(file.path, CSV_PARSER_OPTIONS) do |row|
      process_row row.to_hash
      counter += 1
      save_operations if counter % 5_000 == 0
    end
    save_operations
    reset_operations_counters
    { successes: self.successes, fails: counter - self.successes }
  end

  def process_row(row)
    company = companies[row['company']]
    if company.nil?
      return
    end
    initialize_operation(row, company)
  end

  def initialize_operation(row, company)
    categories = kinds_to_categories row['kind'].try(:split, ';')
    operation = Operation.new row.slice(*HEADERS).merge(company: company)
    categories.each do |category|
      operation.category_operations << CategoryOperation.new(category: category)
    end
    operations.push operation
  end

  def kinds_to_categories(kinds)
    return [] if kinds.nil?
    kinds.map do |kind|
      if categories[kind].present?
        categories[kind]
      else
        category = Category.create(name: kind)
        categories[kind] = category
        category
      end
    end
  end

  def save_operations
    o = Operation.import operations.uniq{ |operation| operation.invoice_num }, recursive: true
    self.operations = []
    self.successes += o.ids.count
  end

  def reset_operations_counters
    companies.each do |k, company|
      Company.reset_counters company.id, :operations
    end
  end
end