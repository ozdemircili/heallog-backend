require 'rails_helper'

RSpec.describe Patient, :type => :model do
  it { should have_many(:doctor_patient_relationships) }
  it { should have_many(:doctors).through(:doctor_patient_relationships) }
end
