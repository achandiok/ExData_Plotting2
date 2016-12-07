#QUESTION3
#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources 
#have seen decreases in emissions from 1999Ð2008 for Baltimore City? Which have seen increases in emissions from 1999Ð2008? 
#Use the ggplot2 plotting system to make a plot answer this question.

# Set the path for the data directory
setwd("C:/Users/ASHISH/Desktop/Cognitive Research/Coursera/DataScienceSpecialization/ExData_Plotting2/")

# Load the Library
library(data.table)
library(ggplot2)

# Read the data file, and convert it to a data table.
# Provide a suitable path for the data table
NEI <- data.table(readRDS('C:/Users/ASHISH/Desktop/Cognitive Research/Coursera/DataScienceSpecialization/ExData_Plotting2/summarySCC_PM25.rds'))

# Summarize the PM2.5 emissions by year, rename the summed column, and convert Type to a factor.
# fips==25410 for Baltimore City, MD.
Data <- NEI[fips=='24510',sum(Emissions), by=c('year', 'type')]
names(Data)[3] <- 'TotalEmissions'
Data$type <- as.factor(Data$type)

#Plot the output
png('plot3.png', width = 480, height = 480)
qplot(year, TotalEmissions, data = Data, group = type, 
      color = type, geom = c("point", "line"), ylab = expression("Total Emissions of PM"[2.5]), 
      xlab = "Year", main = "Total Emissions in U.S. by Type of Pollutant")

dev.off()



