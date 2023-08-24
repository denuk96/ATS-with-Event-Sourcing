class ApplicationsController < ApplicationController
  def index
    applications = Application.includes(:job, :events)
                              .with_active_job
                              .page(params[:page] || 1).per(10)

    render json: ApplicationSerializer.new(applications), status: :ok
  end
end
