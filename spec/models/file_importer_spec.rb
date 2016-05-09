require 'rails_helper'

RSpec.describe FileImporter, type: :model do
  let(:companies) { Companies.order('id asc') }
  file = File.path("spec/fixtures/ImporterApp.csv")

  it "can read the csv file" do
    importer = FileImporter.new(file)
    expect(importer).to be_present
  end

end
