FactoryGirl.define do
  factory :blood_test_asset do
    blood_test nil
    asset { Rack::Test::UploadedFile.new("./spec/assets/img_test1.jpg", "image/jpeg")}
  end

end
