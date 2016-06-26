class OperationsController < ApplicationController
  def index
    render json: CompaniesWithStatisticsAsJson.call
  end

  def create
    response = CsvImporter.call(operations_params[:file])
    render json: response.merge(companies: CompaniesWithStatisticsAsJson.call)
  end

  private

  def operations_params
    params.permit(:file)
  end
end