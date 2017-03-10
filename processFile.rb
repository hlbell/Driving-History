module FileProcessor
    class TripAnalyzer
        def print_data(output)
         x=0
            while x < output.length
               if output[x][2] > 5 && output[x][2] < 100 
                   
                   puts "#{output[x][0]}: #{output[x][1].round} miles @ #{output[x][2].round} mph"
                   
              else
                   puts "#{output[x][0]}: 0 miles"
               end
                x+=1
            end
        end
        
        def get_elapsed_time(interval)
            
            startTime_hours=(interval[0,2].to_i)+0.0+((interval[3,4].to_i)+0.0)/60.to_i
            endTime_hours=(interval[6,7].to_i)+0.0+((interval[9,10].to_i)+0.0)/60.to_i
            
            endTime_hours-startTime_hours
        end
        
        
        def build_output_array(driverArray,tripArray)
            y=0
            outputArray_raw = []
            outputArray = []
            
            while y < driverArray.length
                x=0
                totalMiles=0
                totalTime=0
                avgMph=0
                count=1
                mph=0
                while x < tripArray.length
                    if tripArray[x].include?driverArray[y].to_s
                        totalMiles+=(tripArray[x][(driverArray[y].length+13)..tripArray[x].length].to_i)+0.0
                        totalTime+=get_elapsed_time(tripArray[x][(driverArray[y].length+1)..15])
                        mph=((tripArray[x][16,tripArray[x].length].to_i)+0.0)/(get_elapsed_time(tripArray[x][(driverArray[y].length+1)..15]))
                        
                        count+=1
                    end
                     x+=1
                end
                 outputArray=outputArray_raw.push([driverArray[y],totalMiles,mph])
                y+=1
            end
            print_data(outputArray)
        end
    end
    
    class FileReader < TripAnalyzer
        def read_file(location)
            driverArray=[]
            driverArray_raw =[]
            tripArray_raw=[]
            tripArray=[]
            if location=='input.txt'
                file = File.open("input.txt")
                
            else
                file = File.open("inputTest.txt")
            end
            myArray=[]
            file.each_line{|line| 
                if line.include?("Driver")

                    driverArray=driverArray_raw.push(line[7,line.length].strip).uniq

                elsif line.include?("Trip")

                    tripArray=tripArray_raw.push(line[5,line.length].strip)
                end         
                } 
           
            build_output_array(driverArray,tripArray)
        end
    end
end
    programStart = FileProcessor::FileReader.new
    programStart.read_file("input.txt")
    

