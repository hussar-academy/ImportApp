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
    @successes = 0
    @fails = 0
  end

  private

  attr_accessor :file

  def process_file
    CSV.foreach(file.path, CSV_PARSER_OPTIONS) do |row|
      process_row row.to_hash
    end
    { successes: @successes, fails: @fails }
  end

  def process_row(row)
    company = Company.find_by(name: row['company'])
    if company.nil?
      @fails += 1
      return
    end
    operation = create_operation(row, company)
    operation.persisted? ? @successes += 1 : @fails += 1
  end

  def create_operation(row, company)
    categories = kinds_to_categories row['kind'].try(:split, ';')
    company.operations.create row.slice(*HEADERS).merge(categories: categories)
  end

  def kinds_to_categories(kinds)
    return [] if kinds.nil?
    kinds.map do |kind|
      Category.find_or_create_by(name: kind)
    end
  end
end