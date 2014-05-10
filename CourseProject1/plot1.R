library(data.table)

# Reading the file
allFile <- read.table("household_power_consumption.txt", header = TRUE, colClasses = "character", sep = ";")

# Getting the required rows
data <- allFile[allFile$Date=="1/2/2007" | allFile$Date=="2/2/2007",]
rm(allFile)

# Casting
data$Global_active_power <- as.numeric(data$Global_active_power)

# Creating plot 1
par(bg=NA, ps=12)

hist(data$Global_active_power, 
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     cex=0.5)

dev.copy(png, file = "plot1.png", width = 480, height = 480) ## Copy my plot to a PNG file
dev.off()  ## Don't forget to close the PNG device!
