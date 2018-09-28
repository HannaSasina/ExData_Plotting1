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

#plot4

png(file = "plot4.png", height = 480, width = 480)
attach(theData)
par(mfrow = c(2, 2))
plot(Global_active_power~DateTime, type = "l", ylab = "Global Active Power(kilowatts)",
     xlab = "")
plot(Voltage~DateTime, type = "l", ylab = "Voltage", xlab = "datetime")

plot(Sub_metering_1~DateTime, type = "l", ylab = "Energy sub metering", xlab = "")
lines(Sub_metering_2~DateTime, col = "red")
lines(Sub_metering_3~DateTime, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)

plot(Global_reactive_power~DateTime, type = "l", ylab = "Global_reactive_power", xlab = "datetime")

dev.off()

