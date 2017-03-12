require_relative "processFile"
require "test/unit"
 
class TestSimpleNumber < Test::Unit::TestCase
 
    def test_elapsed_time
      test=FileProcessor::TripAnalyzer.new

      assert_equal(1.25,test.get_elapsed_time("07:15 08:30"))
      assert_equal(0.25,test.get_elapsed_time("07:15 07:30"))
    end
    
    def test_print_data
        test=FileProcessor::TripAnalyzer.new
        
        output=[["Dan",30.200000000000003,36.240000000000016],["Alex",42.0,33.6],["Bob",0,0]]
        
        assert_not_nil(test.print_data(output).to_s)
    end

    def test_read_file
        test=FileProcessor::FileReader.new
        
        assert_not_nil(test.read_file("inputTest.txt"))
        assert(test.read_file("inputTest.txt").to_s.include?"Dan 07:15 07:45 17.3")
        assert(test.read_file("inputTest.txt").to_s.include?"Dan 06:12 06:32 12.9")
        assert(test.read_file("inputTest.txt").to_s.include?"Alex 12:01 13:16 42.0")
        assert_false(test.read_file("inputTest.txt").to_s.include?"Bob")
    end
    
    def test_build_output_array
        test=FileProcessor::TripAnalyzer.new
        
        driverArray=["Dan","Alex","Bob"]
        tripArray=["Dan 07:15 07:45 17.3","Dan 06:12 06:32 12.9","Alex 12:01 13:16 42.0"]
    
#        puts test.build_output_array(driverArray,tripArray)
        assert_not_nil(test.build_output_array(driverArray,tripArray))
        assert(test.build_output_array(driverArray,tripArray).to_s.include?"Dan")
        assert(test.build_output_array(driverArray,tripArray).to_s.include?"30.200000000000003")
        assert(test.build_output_array(driverArray,tripArray).to_s.include?"36.240000000000016")
        
        assert(test.build_output_array(driverArray,tripArray).to_s.include?"Alex")
        assert(test.build_output_array(driverArray,tripArray).to_s.include?"42.0")
        assert(test.build_output_array(driverArray,tripArray).to_s.include?"33.6")
        
        assert(test.build_output_array(driverArray,tripArray).to_s.include?"Bob")
        assert(test.build_output_array(driverArray,tripArray).to_s.include?"0")
        assert(test.build_output_array(driverArray,tripArray).to_s.include?"0") 
    end
end
