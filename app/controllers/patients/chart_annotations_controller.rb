class Patients::ChartAnnotationsController < ApplicationController
  before_action :authenticate_patient!
  protect_from_forgery :except => [:create, :update] #FIXME

  def show
    ann = current_patient.annotations.find(params[:id])
    render json: ann, root: :chart_annotation
  end

  def create
    metric = current_patient.metrics.find(params[:chart_annotation][:patient_metric_id])
    ann = metric.annotations.create(title: params[:chart_annotation][:title], body: params[:chart_annotation][:body], status:  params[:chart_annotation][:status])
    render json: ann, root: :chart_annotation
  end
  
  def update
    ann = current_patient.annotations.find(params[:id])
    ann.update_attributes(title: params[:chart_annotation][:title], body: params[:chart_annotation][:body],  status: params[:chart_annotation][:status])
    render json: ann, root: :chart_annotation
  end
end

