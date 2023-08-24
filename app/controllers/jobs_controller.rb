class JobsController < ApplicationController
  def index
    jobs = Job.page(params[:page] || 1).per(10)

    render json: JobSerializer.new(jobs), status: :ok
  end
end
