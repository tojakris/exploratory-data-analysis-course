# Reading the file
allFile <- read.table("household_power_consumption.txt", header = TRUE, colClasses = "character", sep = ";")

# Getting the required rows
data <- allFile[allFile$Date=="1/2/2007" | allFile$Date=="2/2/2007",]
rm(allFile)

# Casting
data$datetime <- strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Voltage <- as.numeric(data$Voltage)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

# Creating 4 plots
png(filename = "plot4.png", width = 480, height = 480) ## Create my plots in a PNG file

par(bg=NA, ps=12, mfrow = c(2, 2))

# plot 1
with(data, plot(datetime, Global_active_power, 
                type="l",
                xlab = "",
                ylab = "Global Active Power"))

# plot 2
with(data, plot(datetime, Voltage, 
                type="l",
                ylab = "Voltage"))

# plot 3
with(data, plot(datetime, Sub_metering_1, 
                type="n", 
                xlab="", 
                ylab="Energy sub metering"))
with(data, lines(datetime, Sub_metering_1, col="black"))
with(data, lines(datetime, Sub_metering_2, col="red"))
with(data, lines(datetime, Sub_metering_3, col="blue"))

legend("topright", 
       lty = c(1,1,1),
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty = "n" )

# plot 4
with(data, plot(datetime, Global_reactive_power, 
                type="l"))

dev.off()  ## Don't forget to close the PNG device!

