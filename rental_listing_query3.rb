require 'date'
require 'pry'

# The following Ruby hash provides the following information about a property:

# availability of the property by day (N means unavailable, Y means available)
# the property's minimum stay requirement by day (i.e., for at least how many nights 
# the property must be booked if the stay begins on that day)
# the nightly rate of the property by day
# The data is from the start date, inclusive (so 2015-01-01 is unavailable, has a minimum stay of 6 days, and costs $248).


tahoe_cabin = {
  start_date: "2015-01-01",
  availability: "NNNNYYNNNNNNNNNNYYYYYNNNNNNNNYYYNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNYYYYYYYYYNNNNYYYYYYYYNNNNNNNNNNYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY",
  minstay:
"6,5,3,6,6,6,4,6,3,3,6,5,3,3,5,6,6,4,5,2,2,6,3,5,4,6,2,6,6,5,2,4,2,2,4,3,2,5,3,4,2,2,5,4,2,6,3,3,3,3,5,6,5,3,6,4,2,3,2,3,2,4,2,2,6,3,6,4,3,5,4,3,3,2,5,3,4,3,4,6,6,4,4,5,2,3,6,3,5,2,2,4,6,5,5,2,6,6,3,6,2,3,3,6,3,2,3,4,4,4,5,2,2,5,2,3,3,6,5,3,3,3,5,2,4,2,6,5,4,4,3,4,3,3,6,5,5,4,3,3,2,4,6,3,3,6,6,4,2,2,3,4,2,6,5,2,6,3,2,4,3,4,5,6,5,3,6,5,6,2,4,3,4,2,3,5,6,3,2,2,2,6,6,2,5,2,3,2,4,4,4,6,6,4,3,2,4,5,5,2,3,2,4,6,6,5,6,2,6,3,2,6,2,6,2,5,5,5,5,4,2,6,3,2,2,2,6,6,5,5,4,4,5,4,2,2,5,5,5,2,6,4,4,4,3,2,6,3,3,2,4,2,6,6,3,6,4,5,4,4,5,6,6,6,6,3,3,5,5,6,3,5,5,6,6,3,2,4,2,3,5,3,4,3,3,3,3,4,5,2,6,5,6,5,5,4,2,3,3,2,4,6,3,2,3,2,3,3,4,5,3,3,6,5,2,6,4,5,5,6,2,4,6,5,2,5,3,4,6,3,3,3,4,5,4,4,4,5,4,3,6,2,2,2,6,4,2,2,6,4,5,3,3,4,2,5,6,5,6,5,3,5,2,2,5",
  price:
"248,109,138,227,104,207,163,119,249,261,162,286,235,205,210,215,259,227,203,183,181,153,140,258,103,198,253,286,254,133,202,142,163,261,205,133,113,152,130,193,153,140,174,282,128,268,114,199,168,254,296,267,224,249,200,207,160,124,108,165,259,293,143,282,267,129,114,268,249,186,255,124,161,247,297,100,113,170,201,239,283,180,142,220,105,294,226,228,101,108,104,187,238,251,106,259,262,120,174,141,231,207,270,193,292,121,250,166,171,287,220,142,176,195,180,215,155,243,116,249,265,164,172,213,151,132,215,235,116,181,260,199,203,189,251,124,128,152,128,188,140,273,176,208,143,143,108,265,269,273,265,182,275,237,188,183,108,234,137,270,106,273,122,105,171,236,213,278,281,102,117,163,277,104,294,252,210,124,203,253,100,220,205,226,100,236,101,150,148,104,205,110,249,175,131,185,210,262,290,271,214,247,158,210,220,156,137,284,245,212,137,237,235,112,158,278,127,132,272,104,103,274,199,260,154,209,186,260,251,247,180,106,107,102,164,290,166,243,234,244,108,182,249,118,99,131,191,231,247,152,120,146,154,223,209,111,116,194,101,212,163,110,257,196,230,250,273,152,116,185,158,276,293,285,219,101,119,159,170,168,147,104,211,137,235,136,136,152,281,176,134,144,130,298,269,272,101,168,141,198,184,154,186,109,230,185,195,282,265,210,290,265,194,120,122,240,256,280,289,164,109,136,213,267,161,265,162,162,182,196,251,204,191,280,199,243,214,255,180,183,200,114,250,159,267,217,213,263,151,115,223,221,244,261,190,166,112,266,291,283,249,135,102,151,113"
}

# Please provide solutions for the following:

# Write a function that accepts the above object as an argument, and returns an array of all available contiguous date ranges,
# listing only the start and end dates of each range (of the format [[start_date, end_date], [start_date, end_date]]).

def available_ranges(property)

  # convert property start date (string) into date
  date_tracker = Date.parse(property[:start_date])
  # get all Y and N into an array
  availability = property[:availability].split('')

  counter = 0
  y_counter = 0
  start_end_dates = []
  rental_avail_range = []
  available_start_date = nil
  available_end_date = nil

  # iterate through availability array and check if each element meets any criteria
  availability.each do |avail|
    # if N and not in a set of Ys, or Y but have reached end of array
    # set the end date by adding the Y counter to the start date of the first Y in set
    # push end date into start_end_date array, then push whole array into the rental_avail_range array
    # reset start_end_dates array and y_counter, as we've ended the current set of Ys
    # increase counter by 1
    if avail == "N" && y_counter != 0 || avail == "Y" && counter == availability.length - 1
      available_end_date = available_start_date + y_counter
      start_end_dates << available_end_date.to_s
      rental_avail_range << start_end_dates
      start_end_dates = []
      y_counter = 0
      counter += 1
    # if first Y, increment y_counter to signal start of Y set
    # add counter to date_tracker to get starting date of Y set
    # increment counter by 1
    elsif avail == "Y" && y_counter == 0
      y_counter += 1
      available_start_date = date_tracker + counter
      start_end_dates << available_start_date.to_s
      counter += 1
    # if Y and start date already exists in start_end_dates array, means already in set of Ys
    # increment y_counter and counter to move on
    elsif avail == "Y" && start_end_dates[0]
      y_counter += 1
      counter += 1
    # if N, increment counter by 1 and move on
    elsif avail == "N"
      counter += 1
    end
  end
  print rental_avail_range
  puts "Array length: #{rental_avail_range.length}"
end

available_ranges tahoe_cabin

# Write a function that, given a start date and end date, returns the total cost of booking the property for that date range, 
# or zero if the property is unavailable for any date in the range.

def cost_of_booking(property, start_date, end_date)
  
  # splitting everything into arrays for ease of access
  availability = property[:availability].split('')
  minstay = property[:minstay].split(',')
  price = property[:price].split(',')

  # request = {
  #   availability: property[:availability].split(''),
  #   minstay: property[:minstay].split(','),
  #   price: property[:price].split(',')
  # }

  total_price = []

  # use property's start date to calculate index of start date
  # get indexes of start and end dates, then creating a range using those indexes to form an array
  property_start_date = Date.parse(property[:start_date])
  start_date_rational = Date.parse(start_date) - property_start_date
  start_array_index = start_date_rational.to_i
  end_date_rational = Date.parse(end_date) - property_start_date
  end_array_index = end_date_rational.to_i
  total_stay = *(start_array_index...end_array_index)

  # check to see if the total number of days is less than the minimum stay for the starting date
  # if total number of days is greater than min stay amount, proceed to iterate through the total stay array
  # check first if any of the requested dates have "N" in them
  # if all "Y", get the price of each day's stay and shovel into total price array
  # use reduce to sum up all elements in total price array and return that total amount
  if total_stay.length < minstay[total_stay[0]].to_i
    puts "Sorry! The minimum stay for this starting date is #{minstay[total_stay[0]]} nights!"
    return 0
  else
    total_stay.each do |i|
      if availability[i] == "N"
        puts "Sorry! One or more of the dates in your range have already been booked!"
        return 0
      else
        total_price << price[i].to_i
        puts price[i].to_i
      end
    end
    puts "Days: #{total_stay.length}"
    puts "Minimum stay: #{minstay[total_stay[0]]}"
    puts "Total Cost: #{total_price.reduce(:+)}"
  end
end

cost_of_booking(tahoe_cabin, "2015-01-06", "2015-01-07")