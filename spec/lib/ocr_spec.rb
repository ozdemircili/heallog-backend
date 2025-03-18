require 'rails_helper'

RSpec.describe BloodTestParser do
  before :all do
    @obj = BloodTestParser.new('./spec/assets/img_test1.jpg', :es, :coll_garces)
    @obj.parse
    puts @obj.results
  end
  it "Parses values without comma" do
    expect(@obj.results[:colesterol][:value]).to eq(41.0)
  end

  it "Parses values with comma" do
    expect(@obj.results[:uricemia][:value]).to eq(6.4)
  end

  it "Parses values after block" do
    expect(@obj.results[:ptt][:value]).to eq(27.5)
  end

  it "Parses values on multiple lines" do
    expect(@obj.results[:prothrombin_time][:multi]).to eq(true)
  end
end
