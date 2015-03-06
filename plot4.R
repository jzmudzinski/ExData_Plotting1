# be sure to download the data file from:
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# and unzip it into "data" subdirectory of your working dir

# clear the workspace
rm(list=ls())

# import csv data with ";" as field separator
input <- read.csv("data/household_power_consumption.txt", sep = ";")

# extract desired data
data <- input[input$Date == "1/2/2007" | input$Date == "2/2/2007",]

# create column with date and time merged as POSIXct
data$Timestamp <- as.POSIXct(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")

# convert factor Global_active_power to numeric
data$Global_active_power <- as.numeric(levels(data$Global_active_power)[data$Global_active_power])
data$Sub_metering_1 <- as.numeric(levels(data$Sub_metering_1)[data$Sub_metering_1])
data$Sub_metering_2 <- as.numeric(levels(data$Sub_metering_2)[data$Sub_metering_2])
data$Voltage <- as.numeric(levels(data$Voltage)[data$Voltage])
data$Global_reactive_power <- as.numeric(levels(data$Global_reactive_power)[data$Global_reactive_power])

# write a png file
png("plot4.png")
par(mfrow = c(2, 2))

# 1st plot
plot(data$Timestamp, data$Global_active_power, 
     ylab = "Global Active Power (kilowatts)", 
     type = "l", xlab = "")

# 2nd plot
plot(data$Timestamp, data$Voltage, 
     ylab = "Voltage", 
     type = "l", xlab = "datetime")

# 3rd plot
plot(data$Timestamp, data$Sub_metering_1, 
     ylab = "Energy sub metering", type = "l", xlab = "")
lines(data$Timestamp, data$Sub_metering_2, col = "red")
lines(data$Timestamp, data$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1,1,1), col = c("black", "red", "blue"), bty = "n" )

# 4th plot
plot(data$Timestamp, data$Global_reactive_power, 
     ylab = "Global_reactive_power", 
     type = "l", xlab = "datetime")

dev.off()

