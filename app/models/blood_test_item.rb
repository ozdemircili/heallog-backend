class BloodTestItem < ActiveRecord::Base
  belongs_to :blood_test
  has_many :connected_tests, class_name: "BloodTestItem", foreign_key: :connected_to_id
  belongs_to :connected_to, class_name: "BloodTestItem"
end
