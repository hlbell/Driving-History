require_relative "processFile"
require "test/unit"
 
class TestSimpleNumber < Test::Unit::TestCase
 
  def test_elapsed_time
      test=FileProcessor::TripAnalyzer.new

      assert_equal(1.25,test.get_elapsed_time("07:15 08:30"))
      
      assert_equal(0.25,test.get_elapsed_time("07:15 07:30"))
  end
    
    def test_print_data
        test=FileProcessor::FileReader.new
    
        assert_not_nil(test.read_file("inputTest.txt").to_s)
      
    end
 
end