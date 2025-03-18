class OmniauthCallbacksController < ApplicationController
  helper_method :resource_class
  helper_method :resource_scope
  helper_method :current_resource

  def facebook
   user = resource_class.find_with_omniauth(env["omniauth.auth"], current_resource)
    if user.persisted?
      sign_in_and_redirect resource_scope, user, event: :authentication
    end
  end

  def humanapi
    auth = Humanapi::Auth.finish_auth(params.merge!({
      clientSecret: ENV.fetch("HUMANAPI_CLIENT_SECRET")}))
    
    identity = current_resource.create_humanapi_identity(auth)
    if identity.persisted?
      render :nothing => true, :status => 200
    else
      render :nothing => true, :status => 422
    end
  end

  def failure
    redirect_to new_session_path(resource_scope)
  end

  private
  def resource_class
    obj = request.env["omniauth.params"] || params
    case obj["resource_class"]
    when "doctor"
      Doctor
    when "patient"
      Patient
    end
  end
  
  def resource_scope
    obj = request.env["omniauth.params"] || params
    case obj["resource_class"]
    when "doctor"
      :doctor
    when "patient"
      :patient
    end
  end
  
  def current_resource
    obj = request.env["omniauth.params"] || params
    case obj["resource_class"]
    when "doctor"
      current_doctor
    when "patient"
      current_patient
    end
  end
end
