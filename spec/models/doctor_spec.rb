require 'rails_helper'

RSpec.describe Doctor, :type => :model do
  it { should have_many(:doctor_patient_relationships) }
  it { should have_many(:patients).through(:doctor_patient_relationships) }

  it { should belong_to(:istitution) }
end
