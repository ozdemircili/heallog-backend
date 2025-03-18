module Omniauthable
  extend ActiveSupport::Concern

  included do
    has_many :identities, as: :omniauthable
  end

  def create_humanapi_identity(auth)
    h_id = self.identities.where(provider: :humanapi, uid: auth["humanId"]).first
    if h_id.nil?
      return self.identities.create({
        provider: :humanapi, uid: auth["humanId"],
        token: auth["accessToken"], public_token: auth["publicToken"]
      })
    else
      h_id.update_attributes({
        token: auth["accessToken"], public_token: auth["publicToken"]
      })
      return h_id
    end
  end

  def method_missing(meth, *args, &block)
    if meth.to_s =~ /^(.+)_identity$/
      self.identities.find_by_provider($1)
    else
      super
    end
  end

  module ClassMethods
    def find_with_omniauth(auth, signed_in_resource = nil)
      identity = Identity.find_with_omniauth(auth, signed_in_resource)

      user = signed_in_resource || identity.try(:omniauthable) || 
        self.find_by_email(auth.info.email)

      if user.nil?
        user = self.create({
          first_name: auth.info.first_name,
          last_name: auth.info.last_name,
          email: auth.info.email || "temp@me-#{auth.uid}-#{auth.provider}.com",
          password: Devise.friendly_token[0,20]
        })
      end

      if identity.nil?
        Identity.create_with_omniauth(auth, user)
      end

      return user
    end
  end
end
