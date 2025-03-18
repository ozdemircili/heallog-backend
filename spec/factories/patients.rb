FactoryGirl.define do
  factory :patient do
    sequence :first_name do |n|
      "patient#{n}"
    end
    sequence :last_name do |n|
      "lastname#{n}"
    end
    sequence :email do |n|
      "patient#{n}@example.com"
    end
    password "123123123"
  end

end
