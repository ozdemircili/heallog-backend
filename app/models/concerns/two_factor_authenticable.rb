module TwoFactorAuthenticable
  def send_otp_secret
    self.update_attribute(:otp_secret, self.class.generate_otp_secret)
    SMS_PROVIDER.send_message(from: "HealLog", to: self.phone_number, text: "Hi, you requested a one time authentication token. TOKEN: #{self.current_otp}")
  end
end
