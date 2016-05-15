require 'csv'

# CSV file importer class
class CSVImporter
  attr_reader :companies, :categories, :non_parsed_rows, :rows

  def initialize(file)
    @file             = file
    @kinds            = []
    @companies        = []
    @rows             = []
    @non_parsed_rows  = 0
  end

  # Counting the errors and parsing in one move!
  # faster than the next method
  def scan
    CSV.foreach(@file, headers: true) do |row|
      @kinds << row['kind']

      if row['invoice_num'].nil? || row['company'].nil? || row['invoice_date'].nil? ||row['amount'].nil? ||
          row['status'].nil? || row['operation_date'].nil?
        @non_parsed_rows += 1
      else
        @companies << row['company']
        @rows.push(
          company:        row['company'],
          invoice_num:    row['invoice_num'],
          operation_date: row['operation_date'],
          invoice_date:   row['invoice_date'],
          amount:         row['amount'],
          reporter:       row['reporter'],
          notes:          row['notes'],
          status:         row['status'],
          kind:           row['kind'],
        )
      end
    end
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
end
