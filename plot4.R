library(downloader)
library(dplyr)

if(!file.exists("household.zip")) {
  fileUrl <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download(fileUrl, dest = "household.zip", mode = "wb")
  unzip("household.zip")
}
reqTable <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE, na.strings = c("", "?", "NA"))
reqTable <- mutate(reqTable, datetime = paste(Date, Time))
reqTable$Date  <- as.Date(reqTable$Date, format = "%d/%m/%Y")
myTable <- filter(reqTable, Date == as.Date("2007/02/01") | Date == as.Date("2007/02/02"))
myTable$datetime <- strptime(myTable$datetime, format = "%d/%m/%Y %H:%M:%S")

png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
plot(myTable$datetime, myTable$Global_active_power, type = "l", main = NULL, xlab = NA, ylab = "Global Active Power")

plot(myTable$datetime, myTable$Voltage, type = "l", main = NULL, xlab = "datetime", ylab = "Voltage")

plot(myTable$datetime, myTable$Sub_metering_1, type = "l", xlab = NA, ylab = "Energy sub metering")
lines(myTable$datetime, myTable$Sub_metering_2, col = "brown1")
lines(myTable$datetime, myTable$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "brown1", "Blue"), bty = "n")

plot(myTable$datetime, myTable$Global_reactive_power, type = "l", main = NULL, xlab = "datetime", ylab = "Global_reactive_power")

dev.off()