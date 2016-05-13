class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  # GET /companies
  # GET /companies.json
  def index
    @companies = Company.order('id asc').includes(:operations)
  end

  # POST /companies
  # POST /companies.json
  def create

  end

  private

  def company_params
      params[:company]
  end
end
