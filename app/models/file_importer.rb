require 'csv'

# CSV file importer class
class FileImporter
  attr_reader :companies, :categories, :non_parsed_rows, :rows

  def initialize(file)
    @non_parsed_rows = 0
    scan(file)
  end

  def scanner(file)
    kinds       = []
    companies   = []
    rows        = []

    CSV.foreach(file, headers: true) do |row|
      kinds << row['kind']
      # Counting the non parsed rows due to absense of company field.
      if row['company'].nil?
        @non_parsed_rows += 1
      else
        companies << row['company']
        rows.push({
          company: row['company'],
          invoice_num: row['invoice_num'],
          operation_date: row['operation_date'],
          amount: row['amount'],
          reporter: row['reporter'],
          notes: row['notes'],
          kind: row['kind']
        })
      end
    end
    @categories = kind_parser(kinds)
    @companies  = company_parser(companies)
    @rows       = rows_cleaner(rows)
  end
  alias scan scanner

  private

  def kind_parser(data)
    data.join(' ').tr(';', ' ').gsub(/  /, ' ')
        .split(' ').map(&:capitalize).uniq!
  end

  # Clean the spaces before company name if there any.
  def company_parser(data)
    data.map(&:lstrip)
  end
end
