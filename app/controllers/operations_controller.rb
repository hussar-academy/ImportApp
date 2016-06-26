class OperationsController < ApplicationController
  def index
    render json: Company.includes(:operations).where('operations_count > ?', 0)
  end

  def create
    response = CsvImporter.call(operations_params[:file])
    companies = Company.includes(:operations).where('operations_count > ?', 0)
    serializered_companies = ActiveModel::Serializer::CollectionSerializer.new(
      companies,each_serializer: CompanySerializer)
    #response.merge! companies: Company.includes(:operations).where('operations_count > ?', 0)
    render json: response.merge(companies: serializered_companies.as_json)
  end

  private

  def operations_params
    params.permit(:file)
  end
end