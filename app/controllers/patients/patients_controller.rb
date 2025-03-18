class Patients::PatientsController < ApplicationController
  before_action :authenticate_patient!
  skip_before_filter :verify_authenticity_token


  def show
    render json: current_patient, root: :patient
  end

  def update
    current_patient.update_attributes(patient_params)
    render json: current_patient, root: :patient
  end

  private
  def patient_params
    params[:patient].extract!(:age_in_months, :age_in_words, :current_weight, :current_height, 
                                    :blood_pressure, :heart_rate, :blood_oxygen)
    params.require(:patient).permit(:first_name, :last_name, :email, :phone_number, :birth_date) 
  end

end



