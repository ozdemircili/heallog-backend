class BloodTest < ActiveRecord::Base
  belongs_to :patient
  has_many :items, class_name: "BloodTestItem"
  has_many :assets, class_name: "BloodTestAsset"


  state_machine :processing_state, initial: :pending do

    after_transition on: :process do |obj, _|
      BloodTestParserJob.perform_later(obj.id)
    end

    event :process do
      transition :pending => :processing
    end
    
    event :processing_fail do
      transition :processing => :failed
    end
    
    event :processing_success do
      transition :processing => :success
    end
  end
end
