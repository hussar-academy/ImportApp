class OperationsController < ApplicationController
  def index
    render json: Company.includes(:operations).where('operations_count > ?', 0)
  end

  def create
    CsvImporter.call(operations_params[:file])
    render json: Company.includes(:operations).where('operations_count > ?', 0)
  end

  private

  def operations_params
    params.permit(:file)
  end
end