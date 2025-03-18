require 'tesseract'
# htest is an hash of all the possible test exams 
class BloodTestParser
  attr_accessor :file, :htest, :lang, :test_format
  attr_reader :results

  def initialize(f, l, t)
    @file = f
    @test_format = t
    @lang = l
    @results = HashWithIndifferentAccess.new
    init_multi_line_tests
    @engine = Tesseract::Engine.new do |e| 
      e.path = "#{Rails.root}/tessdata"
      e.language  = @lang 
    end
  end

  def parse
    @engine.each_line_for(@file) do |line|
      puts line
      test, value = look_for_known_tests(line.text, htests)
      unless test.nil?
        if @in_block
          @results[@test_block] ||= {multi: true}
          if value
            if not htests[test].nil?
              @results[test] = {value: value}
            else
              @results[@test_block][:nested_fields] ||= {}
              @results[@test_block][:nested_fields][test] = {value: value}
            end
          end
        else
          @results[test] = {value: value}
        end
      end
    end
  end

  def htests
    yaml = YAML.load_file([Rails.root,'config','blood_tests', "#{@test_format}.yml"].join('/'))
    return HashWithIndifferentAccess.new(yaml["tests"])
  end
  
  private
  def extract_value line, m, unit 
    res = line.match(/#{m}.(\d+,\d+)#{unit}/) || line.match(/#{m}.(\d+,\d+)./) ||
    line.match(/#{m}.(\d+).#{unit}/)  ||  line.match(/#{m}.(\d+)./) 

    res[1]
  end

  def look_for_known_tests line, htests
    if @in_block
      look_for_known_tests_in_block line, htests
    else
      look_for_known_tests_ouside_block line, htests
    end
  end

  def look_for_known_tests_in_block(line, htests)
    htests[@test_block][:nested_fields].each do |k, v|
      v[:matches].each do |m|
        m = Regexp.escape(m)
        if line.match(m)
          raw_values = extract_value(line, m, v[:unit])
          value = raw_values.gsub(",",".").to_f
          return k, value
        end
      end
    end
    init_multi_line_tests
    return look_for_known_tests_ouside_block(line, htests)
  end

  def look_for_known_tests_ouside_block(line, htests)
    htests.each do |k, v|
      v[:matches].each do |m|
        m = Regexp.escape(m)
        if line.match(m)
          puts line
          if v[:without_value].nil? || v[:without_value] == false
            raw_values = extract_value(line, m, v[:unit])
            value = raw_values.gsub(",",".").to_f
          end

          if(v.has_key?(:nested_fields))
            @in_block = true
            @test_block = k
          end
          return k, value
        end
      end
    end
    return nil, nil
  end

  def init_multi_line_tests
    puts "init_multi_line_tests"
    @in_block = false
    @test_block = nil
  end
end


=begin

obj = BloodTestParser.new('./IMG_0156.jpg', :es)
obj.parse
puts obj.results
=end

