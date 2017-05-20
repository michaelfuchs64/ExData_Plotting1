
if(is.null(dataPC)) {
    ## Load entire file
    dataPC <- read.table("household_power_consumption.txt", sep=";", header = T, stringsAsFactors = F)
    ## Convert date and time to proper classes
    dataPC$Date <- as.Date(dataPC$Date, "%d/%m/%Y")
    dataPC$Time <- as.POSIXct(strptime(paste(dataPC$Date, dataPC$Time), "%Y-%m-%d %H:%M:%S"))
}

if(is.null(dataPC2days)) {
    ## Filter out Feb 1-2, 2007
    dataPC2days <- filter(dataPC, year(Time) == 2007 & month(Time) == 2 & mday(Time) < 3)
    ## make columns 3-9 numeric
    dataPC2days[,3:9] <- lapply(dataPC2days[,3:9], as.numeric)
}

## Plot 4
png(filename = "plot4.png")
par(mfrow = c(2, 2))
with(dataPC2days, {
    #4.1
    plot(Time, Global_active_power, ylab="Global Active Power (kilowatts)", xlab="", type="n")
    lines(Time, Global_active_power)
    
    #4.2
    plot(Time, Voltage, main="", xlab="datetime", ylab="Voltage", type="n")
    lines(Time, Voltage)
    
    #4.3
    plot(Time, Sub_metering_1, main="", xlab="", ylab="Energy sub metering", type="n")
    lines(Time, Sub_metering_1, col="black")
    lines(Time, Sub_metering_2, col="red")
    lines(Time, Sub_metering_3, col="blue")
    legend("topright", lwd = 1, col = c("black", "red", "blue"), bty = "n",
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    
    #4.4
    plot(Time, Global_reactive_power, main="", xlab="datetime", ylab="Global_reactive_power", type="n")
    lines(Time, Global_reactive_power)
})
dev.off()

