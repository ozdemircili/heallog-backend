require 'rails_helper'

feature "Doctors Authentication", :type => :feature do
  let(:doctor) { create(:doctor) }
  it "Works" do
    login_as(doctor, scope: :doctor)
    visit new_doctor_session_path
    expect(current_path).to eq(doctors_dashboard_path)
  end
end

