require 'csv'

# CSV file importer class
class CSVImporter
  attr_reader :companies, :categories, :non_parsed_rows, :rows

  def initialize(file)
    @file             = file
    @non_parsed_rows  = 0
    @kinds            = []
    @companies        = []
    @rows             = []
  end

  # Counting the errors and parsing in one move!
  def scan
    CSV.foreach(@file, headers: true) do |row|
      @kinds << row['kind']
      if row['company'].nil?
        @non_parsed_rows += 1
      else
        @companies << row['company']
        @rows.push(
          company:        row['company'],
          invoice_num:    row['invoice_num'],
          operation_date: row['operation_date'],
          amount:         row['amount'],
          reporter:       row['reporter'],
          notes:          row['notes'],
          kind:           row['kind']
        )
      end
    end
    rows_cleaner
  end

  # Almost a different implmentation of CSVImporter#scan using less syntax,
  # but with really really bad performance.
  def self.parse(csv_file)
    data = []
    # Creating nil values instead of empty strings,
    CSV::Converters[:blank_nil] = lambda do |field|
      field && field.empty? ? nil : field
    end
    CSV.foreach(csv_file, headers: true,
                          header_converters: :symbol,
                          converters: [:all, :blank_nil]) do |row|
      data << row.to_hash
    end
    data
  end

  private

  def rows_cleaner
    @categories = kind_parser(@kinds)
    @companies  = company_parser(@companies)
    hash_cleaner(@rows)
  end

  def kind_parser(data)
    data.join(' ').tr(';', ' ').gsub(/  /, ' ')
        .split(' ').map(&:capitalize).uniq!
  end

  # Clean the spaces before company name if there any.
  def company_parser(data)
    data.map(&:lstrip)
  end

  def hash_cleaner(data)
    data.map { |key| key[:company] = key[:company].lstrip }
  end
end
