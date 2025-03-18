class Identity < ActiveRecord::Base
  belongs_to :omniauthable, polymorphic: true

  validates :provider, uniqueness: { scope: [:omniauthable_type, :omniauthable_id] }

  def self.find_with_omniauth(auth, signed_in_resource = nil)
    identity = find_by(uid: auth.uid, provider: auth.provider)
    if (not signed_in_resource.nil?) and (not identity.nil?) and 
      (not identity.omniauthable.nil?)

      raise IdentityAlreadyInUse if signed_in_resource.id != identity.omniauthable.id
    end
    return identity
  end

  def self.create_with_omniauth(auth, omniauthable)
    create(uid: auth.uid, provider: auth.provider, 
           token: auth.credentials.token, omniauthable: omniauthable)
  end
end
