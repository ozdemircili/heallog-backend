class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?


  def after_sign_in_path_for(resource)
    return stored_location_for(resource) || patients_dashboard_path if resource.kind_of? Patient
    return stored_location_for(resource) || doctors_dashboard_path if resource.kind_of? Doctor
  end
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) << :otp_attempt
    devise_parameter_sanitizer.for(:sign_up) << :first_name
    devise_parameter_sanitizer.for(:sign_up) << :last_name
  end
end
