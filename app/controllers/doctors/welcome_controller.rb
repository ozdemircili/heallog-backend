class Doctors::WelcomeController < ApplicationController
  before_action :authenticate_doctor!

  def index
    render layout: "doctors_dashboard"
  end
end

