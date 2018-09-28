#read in the data
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
theData <- read.table(unz(temp, "household_power_consumption.txt"), sep = ";", na.strings = "?", header = TRUE, stringsAsFactors = FALSE, quote = "")
unlink(temp)

#Convert date format
theData$Date <- as.Date(theData$Date, format = "%d/%m/%Y")

# subset to needed dates
theData <- subset(theData, theData$Date >= "2007-02-01" & theData$Date <= "2007-02-02")

#convert time format
theData$DateTime <- strptime(paste(theData$Date, theData$Time), "%Y-%m-%d %H:%M:%S")

#plot1
png(file = "plot1.png", height = 480, width = 480)
with(theData, hist(Global_active_power, main= "Global Active Power", 
                   xlab = "Global Active Power(kilowatts)",
                   ylab = "Frequency",
                   col = "red"))
dev.off()