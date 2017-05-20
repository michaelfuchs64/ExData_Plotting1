
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

## Plot 3
png(filename = "plot3.png")
par(mfrow = c(1, 1))
with(dataPC2days, {
    plot(Time, Sub_metering_1, main="", xlab="", ylab="Energy sub metering", type="n")
    lines(Time, Sub_metering_1, col="black")
    lines(Time, Sub_metering_2, col="red")
    lines(Time, Sub_metering_3, col="blue")
    legend("topright", lwd = 1, col = c("black", "red", "blue"), bty = "n",
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    
})
dev.off()

