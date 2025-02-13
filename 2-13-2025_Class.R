#Lecture on 2-13-2025
#2.7 Defining functions 

#creating our own mean function
#returns arithmetic average by default, if not it calculates geometric mean instead 
avg= function(x, arithmetic=TRUE){
  if(!is.numeric(x)) {stop("stop it!! give me a number silly")}
  n= length(x)
  answer= ifelse(arithmetic, sum(x)/n, prod(x)^(1/n))
  return(answer)
}
temp= c(1,2,3,4,5)
avg(temp)
avg(temp, arithmetic=FALSE)

temp2= c(4,7,9,12,55)
avg(temp2, TRUE)

fake_temp= c("boo", "scary", "ghost")
avg(fake_temp)


#Exercise 7.1
letter_grade= function(x){
  if(x>=90){
    return("A")
  }
  if(x<90 & x>=80){
    return("B")
  }
  if(x<80 & x>=70){
    return("C")
  }
  if(x<70 & x>=60){
    return("D")
  }
  if(x<=60){
    return("F")
  }
}
letter_grade(80)

#2.8 Global Temperature 
url = 'https://data.giss.nasa.gov/gistemp/graphs/graph_data/Global_Mean_Estimates_based_on_Land_and_Ocean_Data/graph.txt'
temp_anomaly= read.delim(file=url, skip= 5, sep= "", header= FALSE, col.names = c("Year", "No_smoothing", "Lowess_5"))
head(temp_anomaly)
tail(temp_anomaly)

plot(No_smoothing ~ Year, data=temp_anomaly, type="b") #type "b" is the point and line (both)

plot(No_smoothing ~ Year, data=temp_anomaly, type="l")+ #the plus means that if i run this line then run the next one 
  lines(Lowess_5 ~ Year, data=temp_anomaly, col= "red", lwd=2)+
  abline(v=1998, lty="dashed")+ #this adds a vertical line at a specified value 
  abline(v=2013, lty="dashed")

#lets look at the "climate change pause" between 1998 and 2013
temp_1998= temp_anomaly$No_smoothing[temp_anomaly$Year==1998]
temp_2012= temp_anomaly$No_smoothing[temp_anomaly$Year==2012]

plot(No_smoothing ~ Year, data=temp_anomaly, type="l")+ #the plus means that if i run this line then run the next one 
  lines(Lowess_5 ~ Year, data=temp_anomaly, col= "red", lwd=2)+
  abline(v=1998, lty="dashed")+ #this adds a vertical line at a specified value 
  abline(v=2013, lty="dashed")+
  lines(c(temp_1998, temp_2012)~c(1998,2012), col="blue", lwd= 3)

#lets make a moving average function to plot on the climate data 
#expects user to pass a 1-dim vector of data 
calc_rolling_avg= function(data, moving_window=5){
  result= rep(NA, length(data))
  for (i in seq(from=moving_window, to=length(data))){
    result[i]= mean(data[seq(from= (i-moving_window+1), to=i)])
  }
  return(result)
}
calc_rolling_avg(data=seq(100))

temp_anomaly$avg_5yr= calc_rolling_avg(data=temp_anomaly$No_smoothing)

plot(No_smoothing ~ Year, data=temp_anomaly, type="l")+ #the plus means that if i run this line then run the next one 
  lines(avg_5yr ~ Year, data=temp_anomaly, col= "red", lwd=2)+
  abline(v=1998, lty="dashed")+ #this adds a vertical line at a specified value 
  abline(v=2013, lty="dashed")+
  lines(c(temp_1998, temp_2012)~c(1998,2012), col="blue", lwd= 3)

#Exercise 8.1
#lets add a 10 and 20 year average!
temp_anomaly$avg_10yr= calc_rolling_avg(data=temp_anomaly$No_smoothing, moving_window = 10)
temp_anomaly$avg_20yr= calc_rolling_avg(data=temp_anomaly$No_smoothing, moving_window = 20)

plot(No_smoothing ~ Year, data=temp_anomaly, type="l")+ #the plus means that if i run this line then run the next one 
  lines(avg_5yr ~ Year, data=temp_anomaly, col= "red", lwd=2)+
  lines(avg_10yr ~ Year, data=temp_anomaly, col= "blue", lwd=2)+
  lines(avg_20yr ~ Year, data=temp_anomaly, col= "green", lwd=2)




