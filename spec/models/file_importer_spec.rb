require 'rails_helper'

RSpec.describe FileImporter, type: :model do
  let(:categories) { ["Client", "Delegation", "Important", "Internal", "Negligible", "Other"] }
  file = File.path('spec/fixtures/ImporterApp.csv')

  it "should read the csv file" do
    importer = FileImporter.new(file)
    expect(importer).to be_present
  end

  it "should scan the file" do
    importer = FileImporter.new(file)
    expect(importer.categories).to match_array(categories)
  end
end
