#QUESTION6
#Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, 
#California (fips == 06037). Which city has seen greater changes over time in motor vehicle emissions?

# Set a path for the data directory
setwd("C:/Users/ASHISH/Desktop/Cognitive Research/Coursera/DataScienceSpecialization/ExData_Plotting2/")

# Load Library
library(data.table)
library(ggplot2)
library(grid)

# Read the data file, and convert it to a data table.
NEI <- data.table(readRDS('summarySCC_PM25.rds'))
SCC <- data.table(readRDS('Source_Classification_Code.rds'))

# Build the SCC subset for motor vehicle sources.
SCCsubset <- SCC[Data.Category %like% 'Onroad']

# Remove 'Not Used' SCC codes.
SCCsubset <- SCCsubset[-grep('^NOT USED', SCCsubset$SCC.Level.Three),]

# Subset the full NEI dataset for identified SCC codes for Baltimore City and Los Angeles County..
BCNEIsubset <- NEI[SCC %in% SCCsubset$SCC][fips=='24510'] # Baltimore
LANEIsubset <- NEI[SCC %in% SCCsubset$SCC][fips=='06037'] # Los Angeles

# Summarize the emissions while adding a County source column, 
# and combine the two tables for a ggplot dataset.
BCData <- BCNEIsubset[,sum(Emissions), by=year][,County:='Baltimore City']
LAData <- LANEIsubset[,sum(Emissions), by=year][,County:='Los Angeles County']
Data <- rbind(BCData, LAData)
Data$County <- as.factor(Data$County)
names(Data)[2] <- 'TotalEmissions'

png("plot6.png", width = 480, height = 480)

ggplot(data=Data, aes(x=year, y=TotalEmissions, Group=County, color=County)) +
  geom_line(size=1) +
  ggtitle('Total Vehicular PM2.5 Emissions 1999 to 2008:\n Baltimore City vs Los Angeles County') + 
  ylab('Total Emissions (in tons)') +
  theme(plot.title=element_text(face='bold', size=15), 
        axis.title.y=element_text(size=16), 
        axis.text.y=element_text(size=14),
        legend.position=c(0.5,0.5),
        legend.title=element_text(size=15),
        legend.text=element_text(size=14),
        legend.key.size=unit(18,'points'))

dev.off()

