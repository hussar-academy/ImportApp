class ImportController < ApplicationController
  before_action :file_path, only: [:create]
  def index
  end

  def create
    @job_id = CsvProcessorWorker.perform_async(file_path)
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def file_path
    params[:file].path
  end

  def find_company(name)
    @company ||= Company.find_by(name: name)
  end
end
