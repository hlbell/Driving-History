module FileProcessor
    class TripAnalyzer
        def print_data(output)
            x=0
            sorted=output.sort_by{|x| x[1] }.reverse
            while x < sorted.length
               if sorted[x][2] > 5 && sorted[x][2] < 100 
                   puts "#{sorted[x][0]}: #{sorted[x][1].round} miles @ #{sorted[x][2].round} mph"    
               elsif sorted[x][2] == 0 
                   puts "#{sorted[x][0]}: 0 miles"
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
                while x < tripArray.length
                    if tripArray[x].include?driverArray[y].to_s
                        totalMiles+=(tripArray[x][(driverArray[y].length+13)..driverArray[y].length+17].to_f)+0.0
                        totalTime+=get_elapsed_time(tripArray[x][(driverArray[y].length+1)..driverArray[y].length+11])
                    end
                     x+=1
                end
                if totalTime > 0
                    mph=(totalMiles/totalTime)
                else
                    mph=0
                end
                 outputArray=outputArray_raw.push([driverArray[y],totalMiles,mph])
                y+=1
            end
            print_data(outputArray)
            outputArray
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
            driverArray
            tripArray
        end
    end
end
    programStart = FileProcessor::FileReader.new
    programStart.read_file("input.txt")
