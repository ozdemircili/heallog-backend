class BloodTestParserJob < ActiveJob::Base
  queue_as :default

  def perform(blood_test_id)
    blood_test = BloodTest.find(blood_test_id)

    parser = BloodTestParser.new('./spec/assets/img_test1.jpg', :es, :coll_garces)
    parser.parse
    {"prothrombin_time"=>{"multi"=>true, "nested_fields"=>{"quick"=>{"value"=>101.0}, "rati"=>{"value"=>1.0}, "inr"=>{"value"=>1.0}}}, "ptt"=>{"value"=>27.5}, "glucemia"=>{"value"=>92.0}, "uricemia"=>{"value"=>6.4}, "colesterol"=>{"value"=>41.0}}

    parser.results.each do |k, v|
      item = blood_test.items.find_by_test_identifier(k)
      if item.nil?
        item = blood_test.items.create(test_identifier: k, value: v[:value])
        if v[:multi]
          v[:nested_fields].each do |k_n, v_n|
            blood_test.items.create(test_identifier: k_n, value: v_n[:value], connected_to: item)
          end
        end
      end
    end

    blood_test.processing_success

  end
end
