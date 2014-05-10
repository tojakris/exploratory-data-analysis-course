# Reading the file
allFile <- read.table("household_power_consumption.txt", header = TRUE, colClasses = "character", sep = ";")

# Getting the required rows
data <- allFile[allFile$Date=="1/2/2007" | allFile$Date=="2/2/2007",]
rm(allFile)

# Casting
data$DateTime <- strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")
data$Global_active_power <- as.numeric(data$Global_active_power)

# Creating plot 2
par(bg=NA, ps=12)

with(data, 
     plot(DateTime, Global_active_power, 
          type="l",
          xlab = "",
          ylab = "Global Active Power (kilowatts)"))

dev.copy(png, file = "plot2.png", width = 480, height = 480) ## Copy my plot to a PNG file
dev.off()  ## Don't forget to close the PNG device!
