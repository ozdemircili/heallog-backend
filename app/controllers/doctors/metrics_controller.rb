class Doctors::MetricsController < ApplicationController
  before_action :authenticate_doctor!

  def index
    patient = current_doctor.patients.find(params[:patient_id])
    metrics = patient.metrics.where(name: params[:metric][:name], taken_at: params[:metric][:since]..params[:metric][:until])
    render json: metrics, root: :metrics
  end
end



