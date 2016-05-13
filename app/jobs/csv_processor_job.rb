class CsvProcessorJob < ActiveJob::Base
  queue_as :default

  def perform(csv_file)
    file = CSVImporter.new(csv_file)
    logger.info "---------------CSV Job starting ----------------------"
    logger.info "The file is being processed"
    file.scan
    logger.info "The file has been processed completly"
    file.categories.each do |category|
      Category.create(name: category)
    end
  end
end
