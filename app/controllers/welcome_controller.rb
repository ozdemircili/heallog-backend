class WelcomeController < ApplicationController

  def index
  end

  def patient_demo
    guest = Patient.where(guest: true).first
    sign_in_and_redirect :patient, guest    
  end

  def doctor_demo
    guest = Doctor.where(guest: true).first
    sign_in_and_redirect :doctor, guest    
  end

  def contact_us
    ContactMailer.send_contact(params[:contact]).deliver_now()
  end

  def get_otp
    case params[:type]
    when "patient"
      r = Patient.find_by_email(params[:email])
    when "doctor"
      r = Doctor.find_by_email(params[:email])
    end
  
    r.send_otp unless r.nil?

    render :nothing => true, :status => 200
  end
end
