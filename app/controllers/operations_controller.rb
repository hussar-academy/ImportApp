class OperationsController < ApplicationController
  def index
    render json: Operation.all
  end

  def create
    CsvImporter.call(operations_params[:file])
    render json: {}, status: 200
  end

  private

  def operations_params
    params.permit(:file)
  end
end