class Doctors::DoctorsController < ApplicationController
  before_action :authenticate_doctor!

  def show
    render json: current_doctor, root: :doctor
  end

end


