class Doctors::EmergenciesController < ApplicationController
  before_action :authenticate_doctor!

  def index
    render json: current_doctor.emergencies, root: :emergencies
  end
end


