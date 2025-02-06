#Class 2-6-2025
#4 CO2 data

#uses ftp to download most up to date data 
url = 'ftp://aftp.cmdl.noaa.gov/products/trends/co2/co2_mm_mlo.txt'
co2 = read.table(url, col.names = c("year", "month", "decimal_date", "monthly_average", 
                                    "deseasonalized", "n_days", "st_dev_days", 
                                    "monthly_mean_uncertainty"))
head(co2) #check data to make sure column names are good!
summary(co2)
range(co2$decimal_date) #when did data collection start and when did it end
min(co2$monthly_average)
max(co2$monthly_average)

#make a keeling curve!!
pdf(file="figures/my_keeling_curve.pdf", width= 7, height= 5)
plot(monthly_average ~ decimal_date, data= co2, type= "l",
     xlab= "Year", ylab= "Monthly CO2 (ppm)", main= "Keeling Curve")
#deseasonalized data removes natural fluctuation in CO2 levels
lines(y=co2$deseasonalized, x= co2$decimal_date, col="red")
dev.off() #this line closes the pdf line to it writes all the code to the blank pdf file


#examine at seasonal cycle!!
#make new column
co2$seasonal_cycle = co2$monthly_average- co2$deseasonalized
head(co2)
plot(seasonal_cycle ~ decimal_date, data= co2, type= "l",
     xlab= "Year")

#just 2020 to 2025
co2$decimal_date > 2020 #row 743 is where 2020 starts 
which(co2$decimal_date > 2020) #says the rows that are after 2020 

co2_2020to2025 = co2[which(co2$decimal_date >2020), ] #rows and all columns
summary(co2_2020to2025)

plot(seasonal_cycle ~ decimal_date, data= co2_2020to2025, type= "l")

#examine monthly trend across time series 
jan_anomalies = co2$seasonal_cycle[which(co2$month==1)] #just look at month column but give row value for seasonal cycle
mean(jan_anomalies)

co2_monthly_cycle= data.frame(month= seq(12), detrended_monthly_cycle= NA)
co2_monthly_cycle

#puts monthly average anamoly into data
co2_monthly_cycle$detrended_monthly_cycle[1] = mean(co2[co2$month==1, "seasonal_cycle"])
co2_monthly_cycle$detrended_monthly_cycle[2] = mean(co2[co2$month==2, "seasonal_cycle"])
co2_monthly_cycle$detrended_monthly_cycle[3] = mean(co2[co2$month==3, "seasonal_cycle"])
co2_monthly_cycle$detrended_monthly_cycle[4] = mean(co2[co2$month==4, "seasonal_cycle"])
co2_monthly_cycle$detrended_monthly_cycle[5] = mean(co2[co2$month==5, "seasonal_cycle"])
co2_monthly_cycle$detrended_monthly_cycle[6] = mean(co2[co2$month==6, "seasonal_cycle"])
co2_monthly_cycle$detrended_monthly_cycle[7] = mean(co2[co2$month==7, "seasonal_cycle"])
co2_monthly_cycle$detrended_monthly_cycle[8] = mean(co2[co2$month==8, "seasonal_cycle"])
co2_monthly_cycle$detrended_monthly_cycle[9] = mean(co2[co2$month==9, "seasonal_cycle"])
co2_monthly_cycle$detrended_monthly_cycle[10] = mean(co2[co2$month==10, "seasonal_cycle"])
co2_monthly_cycle$detrended_monthly_cycle[11] = mean(co2[co2$month==11, "seasonal_cycle"])
co2_monthly_cycle$detrended_monthly_cycle[12] = mean(co2[co2$month==12, "seasonal_cycle"])

co2_monthly_cycle
plot(detrended_monthly_cycle ~ month, data= co2_monthly_cycle, type= "l")


#Exercise 4.1


#5 For Loops
i=77
print(paste("this is run", i))

#i is the iterand, the thing that is iterated over, in the for loop
for (i in c(1,2,3,4)){
  print(paste("this is run", i))
}
i #now i is 4 not 77 

for (i in c(35:41)){
  print(paste("this is run", i))
}
i #now i is 41 not 4

for (peanut in c("hi", "hello", "hey")){
  print(paste("this is run", peanut))
}
peanut #now hey

#indexing 
#above the loop initialize what you are asking for it to make
my_vector= c(1,3,5,2,4)
n= length(my_vector)
my_square_vector= rep(NA,n) #create new vector the same length as previous
my_square_vector
total= 0
for (i in seq(n)){
  my_square_vector[i] = my_vector[i]^2
  total= total+ my_square_vector[i]
  print(paste("i=", i, "and my_Vector[i]=", my_vector[i], "and my_square_vector[i]=", my_square_vector[i],
              "total=", total))
}

#nested for loop!!
mat= matrix(c(2,0,8,5,5,-4), nrow=2, ncol=3)
mat
mat_sq= matrix(rep(NA,6), nrow=2, ncol=3)
mat_sq
for (i in seq(dim(mat)[1])){
  for (j in seq(dim(mat)[2])){
    mat_sq[i,j] = mat[i,j]^2
    print(paste("i=", i, "j=", j, "mat[i,j]=", mat[i,j],
                "mat_sq[i,j]", mat_sq[i,j]))
  }
}
mat_sq


#Exercise 5.1 







