class OperationsController < ApplicationController
  def index
  end

  def import
    Operation.import(params[:file].tempfile)
    redirect_to root_url, notice: 'Operations imported.'
  rescue
    redirect_to root_url, notice: 'Invalid csv file'
  end
end
