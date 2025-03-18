class DoctorPatientRelationship < ActiveRecord::Base
  belongs_to :doctor
  belongs_to :patient

  before_create :set_token

  state_machine :status, :initial => :pending do
    event :accept do
      transition :pending => :accepted
    end
    
    event :reject do
      transition :pending => :rejected
    end
  end


  private 
  def set_token
    self.token = SecureRandom.hex(12)
  end
end

