require 'csv'

# CSV file importer class
class FileImporter
  def list_current_companies
    @companies = Company.order('id asc')
  end
end
