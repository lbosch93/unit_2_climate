#Lecture 2/11/2025

#while loops
x=5
while (x>0) {
  x=x-1
  print(x)
}

#fishing game with while loop
rnorm(n=1, mean=2, sd=1) #this generates random numbers from a normal distribution

n_fish = 0
total_catch_lb = 0
while(total_catch_lb< 50){
  new_fish_weight= rnorm(n=1, mean=5, sd=1)
  n_fish= n_fish + 1
  total_catch_lb= total_catch_lb + new_fish_weight
  print(n_fish)
  print(total_catch_lb)
}
n_fish
total_catch_lb
#to run the simulation again, read in the variables as 0 again

#2.6 Arctic Sea Ice
url = 'ftp://sidads.colorado.edu/DATASETS/NOAA/G02135/north/daily/data/N_seaice_extent_daily_v3.0.csv'
arctic_ice = read.delim(file=url, skip=2, sep=",", header=FALSE, 
                        col.names = c("Year", "Month", "Day", "Extent", "Missing", "Source_Data"))
head(arctic_ice)
tail(arctic_ice)
#lets make a date column
library(lubridate)

arctic_ice$Date= make_date(year= arctic_ice$Year, month= arctic_ice$Month, day= arctic_ice$Day)
head(arctic_ice)
class(arctic_ice$Date)

plot(Extent~Date, data=arctic_ice, type="l", ylab= "Arctic Sea Ice Extent (million km^2)")


#what is the average sea ice extent each year? 
#get rid of 1978 and 2025 because they are not full years
first_year= min(arctic_ice$Year)+1
last_year= max(arctic_ice$Year)-1
#make data frame for averages
arctic_ice_averages= data.frame(Year= seq(from= first_year, to= last_year),
                                extent_annual_avg= NA, extent_5yr_avg= NA)
head(arctic_ice_averages)
arctic_ice_averages$extent_annual_avg[1] = mean(arctic_ice$Extent[arctic_ice$Year== arctic_ice_averages$Year[1]])
head(arctic_ice_averages)

dim(arctic_ice_averages)
for (i in seq(dim(arctic_ice_averages)[1])) {
  arctic_ice_averages$extent_annual_avg[i] = mean(arctic_ice$Extent[arctic_ice$Year== arctic_ice_averages$Year[i]])
  print(i)
  print(arctic_ice_averages$extent_annual_avg[i])
}

plot(extent_annual_avg ~ Year, data= arctic_ice_averages, type= "l")

#what is the 5 year average of sea extent?
#1981 is the first year I can calculate a 5 year average bc there is 2 years before and after
#2022 is the last year I can calculate a 5 year average for the same reason
#[i] should go from row 3 to row 44 

for (i in seq(from=3, to=dim(arctic_ice_averages)[1]-2)) {
  #this code makes a vector of the years the for loop is looking at and averaging
  years= c( (arctic_ice_averages$Year[i]-2) : (arctic_ice_averages$Year[i]+2) )
  arctic_ice_averages$extent_5yr_avg[i] = mean(arctic_ice$Extent[arctic_ice$Year %in% years])
  print(paste(i, ":", years))
}
head(arctic_ice_averages)
tail(arctic_ice_averages)

#plot the year average against the 5 year average
plot(extent_annual_avg ~ Year, data= arctic_ice_averages, type= "l", col= "red")
lines(extent_5yr_avg ~ Year, data= arctic_ice_averages, type= "l", col= "blue")

arctic_ice_averages$date = make_date(year= arctic_ice_averages$Year,)
head(arctic_ice_averages)

#plot it all together
plot(Extent ~ Date, data= arctic_ice, type= "l")
lines(extent_annual_avg ~ date, data= arctic_ice_averages, type= "l", col= "red")
lines(extent_5yr_avg ~ date, data= arctic_ice_averages, type= "l", col= "blue")

#Exercie 6.1

#find the rate of change in annually average ice extent across the time period
first_extent = arctic_ice_averages$extent_annual_avg[1]
last_extent= arctic_ice_averages$extent_annual_avg[dim(arctic_ice_averages)[1]]
total_change_million_km2 = last_extent - first_extent
total_change_million_km2

first_year= arctic_ice_averages$Year[1]
last_year= arctic_ice_averages$Year[dim(arctic_ice_averages)[1]]
num_years= last_year - first_year

rate= total_change_million_km2/ num_years
rate

#Exercise 6.2



