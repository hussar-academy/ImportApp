require 'csv'

class CsvImporter < BaseService

  CSV_PARSER_OPTIONS = {
    skip_blanks: true,
    headers: true
  }.freeze

  HEADERS = %w(invoice_num invoice_date operation_date amount reporter
    notes status).freeze

  def call
    process_file
  end

  def initialize(file)
    self.file = file
  end

  private

  attr_accessor :file

  def process_file
    ActiveRecord::Base.transaction do
      CSV.foreach(file.path, CSV_PARSER_OPTIONS) do |row|
        process_row row.to_hash
      end
    end
  end

  def process_row(row)
    company = Company.find_by(name: row['company'])
    return if company.nil?
    categories = kinds_to_categories row['kind'].split(';')
    company.operations.create row.slice(*HEADERS).merge(categories: categories)
  end

  def kinds_to_categories(kinds)
    kinds.map do |kind|
      Category.find_or_create_by(name: kind)
    end
  end
end