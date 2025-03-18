FactoryGirl.define do
  factory :blood_test do
    patient
    performed_by "MyString"
    taken_at "2015-01-17 14:30:21"
    processing_state 'pending'
    after(:create) do |blood_test, evaluator|
      create_list(:blood_test_asset, 1, blood_test: blood_test)
    end
  end

end
