require 'rails_helper'

feature "Patients Authentication", :type => :feature do
  let(:patient) { create(:patient) }
  it "Works" do
    login_as(patient, scope: :patient)
    visit new_patient_session_path
    expect(current_path).to eq(patients_dashboard_path)
  end
end
