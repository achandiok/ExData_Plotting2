#QUESTION5
#How have emissions from motor vehicle sources changed from 1999 to 2008 in Baltimore City? 

# Set the path for the data directory
setwd("C:/Users/ASHISH/Desktop/Cognitive Research/Coursera/DataScienceSpecialization/ExData_Plotting2/")

# Load Library
library(data.table)
library(ggplot2)

# Read the data file, and convert it to a data table.
NEI <- data.table(readRDS('summarySCC_PM25.rds'))
SCC <- data.table(readRDS('Source_Classification_Code.rds'))


# Build the SCC subset for motor vehicle sources.
SCCsubset <- SCC[Data.Category %like% 'Onroad']

# Get rid of 'Not Used' SCC codes.
SCCsubset <- SCCsubset[-grep('^NOT USED', SCCsubset$SCC.Level.Three),]

# Subset the full NEI dataset for identified SCC codes, but for Baltimore City only.
NEIsubset <- NEI[SCC %in% SCCsubset$SCC][fips=='24510']

# Sum the emissions.
Data<- NEIsubset[,sum(Emissions), by=year]
names(Data)[2] <- 'TotalEmissions'

#Plot the output
png("plot5.png", width = 480, height = 480)
g = ggplot(Data, aes(year, TotalEmissions))
g + geom_point(color = "black") + geom_line(color = "red") + labs(x = "Year") + 
  labs(y = expression("Total Emissions of PM"[2.5])) + 
  labs(title = "Total Emissions from Motor Vehicle Sources in Baltimore City")
dev.off()
