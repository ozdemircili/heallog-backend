class Doctors::ChartAnnotationsController < ApplicationController
  before_action :authenticate_doctor!
  protect_from_forgery :except => [:create, :update] #FIXME

  def show
    ann = current_doctor.annotations.find(params[:id])
    render json: ann, root: :chart_annotation
  end

  def create
    metric = current_doctor.metrics.find(params[:chart_annotation][:patient_metric_id])
    ann = metric.annotations.create(title: params[:chart_annotation][:title], body: params[:chart_annotation][:body])
    render json: ann, root: :chart_annotation
  end
  
  def update
    ann = current_doctor.annotations.find(params[:id])
    ann.update_attributes(title: params[:chart_annotation][:title], body: params[:chart_annotation][:body])
    render json: ann, root: :chart_annotation
  end
end

