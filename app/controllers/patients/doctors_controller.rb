class Patients::DoctorsController < ApplicationController
  before_action :authenticate_patient!

  def show
    doctor = current_patient.doctors.find(params[:id])
    render json: doctor, root: :doctor
  end

end



