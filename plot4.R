####  This provides the complete code to read in the household power consumption data 
##### from a file saved in the same directory, get the data for the first two days in February 2007
#####  then produce the fourth chart (a panel plot of four other graphs) and save it as a .png file.

pwrdata <-read.table("household_power_consumption.txt", sep = ";", na.strings = "?", header = TRUE)

#Convert the date column from a factor to a date
pwrdata$Date = as.Date(pwrdata$Date, format = "%d/%m/%Y")

#Get the data for the first two days in February 2007
thedata<-pwrdata[pwrdata$Date==as.Date("1/2/2007",format = "%d/%m/%Y") | pwrdata$Date==as.Date("2/2/2007",format = "%d/%m/%Y"),]

#Delete the full data set from memory  - it is no longer needed
> rm(pwrdata)


#Convert the time column from a factor to a time
tempdate <-as.character(thedata$Date)  #string holding the date
temptime <-as.character(thedata$Time)  #string holding the time
tempdatetime = paste(tempdate, temptime)   #string holding both date and time
thedata$Time <-strptime(tempdatetime, "%Y-%m-%d %H:%M:%S")  #Convert the time column


#set up grid for four graphs
par(mfrow = c(2, 2))

#top left panel
plot(thedata$Time,thedata$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)",type = "n")
lines(thedata$Time,thedata$Global_active_power)


#top right panel
plot(thedata$Time,thedata$Voltage, ylab = "Voltage", xlab = "datetime",type = "n")
lines(thedata$Time,thedata$Voltage)


#bottom left panel
plot(thedata$Time,thedata$Sub_metering_1, xlab = "", ylab = "Energy sub metering",type = "n")
lines(thedata$Time,thedata$Sub_metering_1)
lines(thedata$Time, thedata$Sub_metering_2, col = "red")
lines(thedata$Time,thedata$Sub_metering_3, col = "blue")
legend("topright", lty = c(1,1,1), col = c("black", "red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty = "n", cex = 0.7)




#bottom right panel
plot(thedata$Time,thedata$Global_reactive_power, ylab = "Global_reactive_power", xlab = "datetime",type = "n")
lines(thedata$Time,thedata$Global_reactive_power)


#copy the file to a png file
dev.copy(png, height = 480,  width = 480,  file = "plot4.png")
dev.off()   #close the png device
