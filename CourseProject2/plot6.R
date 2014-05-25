################################################################################
# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?
################################################################################

# Load the data
print("This will likely take a few seconds. Be patient!")
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

# Subsetting data. Getting motor vehicle sources data
vehicles <- SCC[SCC$Data.Category=="Onroad",]

# Get Baltimore City, Maryland (fips == "24510")
cities.data <- NEI[NEI$fips == "24510" | NEI$fips == "06037",]

# Merging data
vehicles.data = merge(cities.data,vehicles,by.x="SCC",by.y="SCC")

# Create the data for the plot
library(plyr)

total.emissions <- ddply(cities.data,
                         .(as.factor(year), as.factor(fips)), # convert number to character
                         summarize, 
                         total=sum(Emissions)) # sum to million tons

# Give column names
colnames <- c("year","fips", "tons")
colnames(total.emissions) <- colnames

# Create the plot
library(ggplot2)

png(filename = "plot6.png", width = 807, height = 342) ## Create my plots in a PNG file

qplot(year, 
      data = total.emissions, 
      facets = . ~ fips, 
      geom="bar", 
      weight=tons, 
      main=expression("Total emissions from PM"[2.5]*
                          " from motor vehicle sources"),
      xlab="Years",
      ylab = expression("Amount of PM"[2.5]*" emitted, in tons"),
      fill = fips)

dev.off()  ## Don't forget to close the PNG device!
