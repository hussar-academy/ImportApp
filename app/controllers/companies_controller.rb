class CompaniesController < ApplicationController

  def index
    @companies = Company.order('id asc').includes(:operations)
  end

  # Violating the RESTful prenciples like a boss.
  def fetch_operations
    @company = Company.find(params[:company])
    @operations = @company.operations.includes(:categories)
    respond_to do |format|
      format.json { render json: @operations }
    end
  end

  private

  def company_params
      params[:company]
  end
end
