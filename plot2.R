####  This provides the complete code to read in the household power consumption data 
##### from a file saved in the same directory, get the data for the first two days in February 2007
#####  then produce the second chart (a scatterplot of global active power over the two days) and save it as a .png file.

#read the data in from the file
pwrdata <-read.table("household_power_consumption.txt", sep = ";", na.strings = "?", header = TRUE)

#Convert the data column from a factor to a date
pwrdata$Date = as.Date(pwrdata$Date, format = "%d/%m/%Y")

#Get the data for the first two days in February 2007
thedata<-pwrdata[pwrdata$Date==as.Date("1/2/2007",format = "%d/%m/%Y") | pwrdata$Date==as.Date("2/2/2007",format = "%d/%m/%Y"),]

#Delete the full data set from memory - it is no longer needed
> rm(pwrdata)

#Convert the time column from a factor to a time
tempdate <-as.character(thedata$Date)  #string holding the date
temptime <-as.character(thedata$Time)  #string holding the time
tempdatetime = paste(tempdate, temptime)   #string holding both date and time
thedata$Time <-strptime(tempdatetime, "%Y-%m-%d %H:%M:%S")  #Convert the time column

#plot the graph
plot(thedata$Time,thedata$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)",type = "n")
lines(thedata$Time,thedata$Global_active_power)


#copy the file to a png file
dev.copy(png, height = 480,  width = 480,  file = "plot2.png")
dev.off()   #close the png device
