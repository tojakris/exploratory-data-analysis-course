# Reading the file
allFile <- read.table("household_power_consumption.txt", header = TRUE, colClasses = "character", sep = ";")

# Getting the required rows
data <- allFile[allFile$Date=="1/2/2007" | allFile$Date=="2/2/2007",]
rm(allFile)

# Casting
data$DateTime <- strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

# Creating plot 3
png(filename = "plot3.png", width = 480, height = 480) ## Create my plot in a PNG file

par(bg=NA, ps=12)

with(data, plot(DateTime, Sub_metering_1, 
                type="n", 
                xlab="", 
                ylab="Energy sub metering"))
with(data, lines(DateTime, Sub_metering_1, col="black"))
with(data, lines(DateTime, Sub_metering_2, col="red"))
with(data, lines(DateTime, Sub_metering_3, col="blue"))

legend("topright", 
       lty = c(1,1,1),
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()  ## Don't forget to close the PNG device!
