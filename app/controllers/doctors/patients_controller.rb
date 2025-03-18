class Doctors::PatientsController < ApplicationController
  before_action :authenticate_doctor!

  def show
    patient = current_doctor.patients.find(params[:id])
    render json: patient, root: :patient
  end

end

