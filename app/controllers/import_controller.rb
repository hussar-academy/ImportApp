class ImportController < ApplicationController
  before_action :file_path, only: [:create]
  def index
  end

  def create
    @status = CsvProcessorJob.perform_later(file_path)
    respond_to do |format|
      format.js { flash "#{@status}"}
    end
    head :ok
  end

  def file_path
    params[:file].path
  end
end
