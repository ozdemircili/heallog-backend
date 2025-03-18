FactoryGirl.define do
  factory :doctor do
    sequence :email do |n|
      "doctor#{n}@example.com"
    end
    password "123123123"
  end
end
