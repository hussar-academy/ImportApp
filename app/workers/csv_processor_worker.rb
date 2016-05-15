# Operations worker.
class CsvProcessorWorker
  include Sidekiq::Worker
  include SidekiqStatus::Worker

  sidekiq_options retry: false

  def perform(csv_file)

    state = {
      total: 0,
      successful: 0,
      failed: 0
    }

    @file = CSVImporter.new(csv_file)
    @file.scan

    @file.rows.map do |row|

      categories = row[:kind]&.split(';')&.map do |category_name|
        categories ||= Category.find_or_create_by(name: category_name)
      end

      @company = find_company(row[:company])

      begin
        @operation = Operation.create!(
          company: @company,
          invoice_num: row[:invoice_num],
          invoice_date: parse_date(row[:invoice_date]),
          operation_date: parse_date(row[:operation_date]),
          amount: row[:amount],
          reporter: row[:reporter],
          notes: row[:notes],
          status: row[:status],
        )
        @operation.categories << categories if !categories.nil?
        state[:successful] += 1
      rescue ActiveRecord::RecordInvalid
        state[:failed] += 1
      ensure
        state[:total] += 1
        yield state if block_given?
      end
    end
  end

  private

  def find_company(name)
    company ||= Company.find_or_create_by(name: name)
  end

  def parse_date(date)
    try_parse_date(date, '%m/%d/%Y') ||
    try_parse_date(date, '%Y-%m-%d') ||
    try_parse_date(date, '%d-%m-%Y')
  end

  def try_parse_date(date, format)
    Date.strptime(date, format)
  rescue ArgumentError, TypeError
    nil
  end
end
