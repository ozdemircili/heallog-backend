require 'rails_helper'

RSpec.describe BloodTestParserJob, :type => :job do
  include ActiveJob::TestHelper

  let(:blood_test) { create(:blood_test)}

  it "is enqueued after blood_test transitions to processing" do
     expect(BloodTestParserJob).to receive(:perform_later).once 
     blood_test.process
  end

  context "#perform" do
    it "creates all the items" do
      BloodTestParserJob.perform_now(blood_test.id)
      expect(blood_test.reload.items.count).to eq(8)
      expect(blood_test.items.find_by_test_identifier(:prothrombin_time).connected_tests.count).to eq(3)
    end
  end
end
