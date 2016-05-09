require 'csv'

# CSV file importer class
class FileImporter
  attr_reader :companies, :categories

  def initialize(file)
    scan(file)
  end

  def scan(file)
    categories = []
    companies  = []

    CSV.foreach(file, headers: true) do |row|
      companies  << row['company']
      categories << row['kind']
    end
    @categories = categorize(categories)
  end

  private

  def categorize(data)
    parsed = data.join(' ').tr(';', ' ').gsub(/  /, ' ')
    parsed.split(' ').map(&:capitalize).uniq!
  end
end
