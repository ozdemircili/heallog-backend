class ContactMailer < ApplicationMailer
  def send_contact(params)
    @params = params
    mail(from: "confirm@superviso.com", to: "heal@heallog.com", subject: 'contact from Hellog')
  end
end
