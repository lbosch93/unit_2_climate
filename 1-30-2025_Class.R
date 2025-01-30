#LCB Lecture 1-30-2025

#read in data from the directory
#working within the project so don't have to put the whole file path use relative path
#skip the first 31 lines and values are separated by white space 
#no header because we skipped them so add column names 
ant_ice_loss= read.table(file= "data/antarctica_mass_200204_202408.txt", skip= 31, sep = "", header=FALSE,
           col.names= c("decimal_data", "mass_Gt", "sigma_Gt"))
#shows first 6 rows of a data frame to check data
head(ant_ice_loss)
#shows last 6 rows
tail(ant_ice_loss)
#how many rows and how many columns 
dim(ant_ice_loss)



#do the same with greenland ice data
grn_ice_loss= read.table(file= "data/greenland_mass_200204_202408.txt", skip= 31, sep = "", header=FALSE,
                         col.names= c("decimal_data", "mass_Gt", "sigma_Gt"))
head(grn_ice_loss)
tail(grn_ice_loss)
dim(grn_ice_loss)
summary(grn_ice_loss)

#Let's plot some of the data
plot(x= ant_ice_loss$decimal_data, y= ant_ice_loss$mass_Gt)
#OR
plot(mass_Gt ~ decimal_data, data=ant_ice_loss) 

#change from scatter plot to line
plot(mass_Gt ~ decimal_data, data=ant_ice_loss, type= "l") 

plot(mass_Gt ~ decimal_data, data=grn_ice_loss, type= "l") 

#combine both on the same plot
plot(mass_Gt ~ decimal_data, data=ant_ice_loss, type= "l", ylim= c(-5000,0))
#add the greenland line to the existing plot
lines(mass_Gt ~ decimal_data, data=grn_ice_loss, type= "l", col="red")
#to make the range bigger, add the ylim parameter

#use the data to determine the range by asking about greenland data
range(grn_ice_loss$mass_Gt)
plot(mass_Gt ~ decimal_data, data=ant_ice_loss, type= "l", ylim= range(grn_ice_loss$mass_Gt),
     ylab= "Mass loss (Gt)", xlab= "Year")
lines(mass_Gt ~ decimal_data, data=grn_ice_loss, type= "l", col="red")
#add some labels in the parameters as well

#show gap of data in 2018 in plot by adding an N/a value 
data_break= data.frame(decimal_data= 2018.0, mass_Gt= NA, sigma_Gt= NA)
data_break
#now the plot will show a break in the data because it saw the NA
#bind the rows of two data frames 
ant_ice_loss_with_NA = rbind(ant_ice_loss, data_break)
head(ant_ice_loss_with_NA)
tail(ant_ice_loss)

grn_ice_loss_with_NA = rbind(grn_ice_loss, data_break)

#make data go in order based on date
ordered_rows= order(ant_ice_loss_with_NA$decimal_data)
ant_ice_loss_with_NA = ant_ice_loss_with_NA[ordered_rows, ]
ant_ice_loss_with_NA = ant_ice_loss_with_NA[order(ant_ice_loss_with_NA$decimal_data),]

ordered_rows= order(grn_ice_loss_with_NA$decimal_data)
grn_ice_loss_with_NA = grn_ice_loss_with_NA[ordered_rows, ]
grn_ice_loss_with_NA = grn_ice_loss_with_NA[order(grn_ice_loss_with_NA$decimal_data),]

plot(mass_Gt ~ decimal_data, data=ant_ice_loss_with_NA, type= "l",
     ylim= range(grn_ice_loss$mass_Gt),
     ylab= "Mass Loss (Gt)", xlab= "Year")
lines(mass_Gt ~ decimal_data, data= grn_ice_loss_with_NA, type= "l", col= "red")

#adding uncertainty
head(ant_ice_loss)
pdf('figures/first_pdf_figure')
plot(mass_Gt ~ decimal_data, data=ant_ice_loss_with_NA, type= "l",
     ylim= range(grn_ice_loss$mass_Gt),
     ylab= "Mass Loss (Gt)", xlab= "Year")
lines((mass_Gt + 2*sigma_Gt) ~ decimal_data, data=ant_ice_loss_with_NA, lty= "dashed")
lines((mass_Gt - 2*sigma_Gt) ~ decimal_data, data=ant_ice_loss_with_NA, lty= "dashed")
lines(mass_Gt ~ decimal_data, data= grn_ice_loss_with_NA, lwd= 2, col="red")
lines((mass_Gt + 2*sigma_Gt) ~ decimal_data, data=grn_ice_loss_with_NA, lty= "dashed", col="red")
lines((mass_Gt - 2*sigma_Gt) ~ decimal_data, data=grn_ice_loss_with_NA, lty= "dashed", col="red")
