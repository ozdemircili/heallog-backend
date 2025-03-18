class BloodTestAsset < ActiveRecord::Base
  belongs_to :blood_test
  has_attached_file :asset
  do_not_validate_attachment_file_type :asset
end
