class Patients::WelcomeController < ApplicationController
  before_action :authenticate_patient!

  def index
    render layout: "patients_dashboard"
  end

  def connect
    render json: {status: :success}
  end
end
