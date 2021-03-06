# Creates Plot1 of the Project

# Load required pacakages
library(downloader)
library(dplyr)

# checks for existence of the zip file in the working directory; if not found downloads from given URL
if(!file.exists("household.zip")) {
  fileUrl <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download(fileUrl, dest = "household.zip", mode = "wb")
  unzip("household.zip")
}

#reads into data frame; creates new column "datetime"; filters based on required days; coverts to Date class;
reqTable <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE, na.strings = c("", "?", "NA"))
reqTable <- mutate(reqTable, datetime = paste(Date, Time))
reqTable$Date  <- as.Date(reqTable$Date, format = "%d/%m/%Y")
myTable <- filter(reqTable, Date == as.Date("2007/02/01") | Date == as.Date("2007/02/02"))
myTable$datetime <- strptime(myTable$datetime, format = "%d/%m/%Y %H:%M:%S")

# Generates required plot on screen & png file in working directory
hist(myTable$Global_active_power, col = "Red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()

