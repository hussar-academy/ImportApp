require 'rails_helper'

describe OperationsController do
  let(:csv_file) { fixture_file_upload('ShortExample.csv') }

  describe '#index' do
    before do
      CsvImporter.call(csv_file)
      get :index
      @company = JSON.parse(response.body)[0]
    end

    it 'includes operations_count' do
      expect(@company['operations_count']).to eq 1
    end

    it 'includes accepted_operations_count' do
      expect(@company['accepted_operations_count']).to eq 0
    end

    it 'includes average_amount_of_operations' do
      expect(@company['average_amount_of_operations']).to eq '10862.48'
    end

    it 'includes highest_operation_from_the_current_month' do
      expect(@company['highest_operation_from_the_current_month']).to eq '10862.48'
    end

    it 'includes operations' do
      expect(@company['operations'].count).to eq 1
    end
  end

  describe '#create' do
    before do
      post :create, file: csv_file
      @response = JSON.parse(response.body)
    end

    it 'creates operations' do
      expect(Operation.count).to eq(2)
    end

    it 'includes number of rows that failed import' do
      expect(@response['fails']).to eq 1
    end

    it 'includes number of successfuly imported rows' do
      expect(@response['successes']).to eq 2
    end
    it 'includes companies' do
      expect(@response['companies'].count).to eq 2
    end
  end
end
