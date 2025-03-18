class Relationship < ApplicationMailer
  def invite(params)
    invited = params[:invited] 
    @rel = params[:relationship]
    mail(from: "heal@heallog.com", to: invited.email, subject: "#{invited.name} wants to add you to is contacts" )
  end
end
