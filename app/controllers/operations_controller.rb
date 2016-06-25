class OperationsController < ApplicationController
  def create
    CsvImporter.call(operations_params[:file])
    render json: {}, status: 200
  end

  private

  def operations_params
    params.permit(:file)
  end
end