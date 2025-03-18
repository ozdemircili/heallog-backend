class Patients::MetricsController < ApplicationController
  before_action :authenticate_patient!

  def index
    metrics = current_patient.metrics.where(name: params[:metric][:name], taken_at: params[:metric][:since]..params[:metric][:until])
    render json: metrics, root: :metrics
  end
end



