#QUESTION2
#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == 24510) from 1999 to 2008? 
#Use the base plotting system to make a plot answering this question.

# Set the path for data directory
setwd("C:/Users/ASHISH/Desktop/Cognitive Research/Coursera/DataScienceSpecialization/ExData_Plotting2/")
library(data.table)

# Read the data file, and convert it to a data table.
# Provide a suitable path for the data table
NEI <- data.table(readRDS('C:/Users/ASHISH/Desktop/Cognitive Research/Coursera/DataScienceSpecialization/ExData_Plotting2/summarySCC_PM25.rds'))

# Summarize the PM2.5 emissions by year, and rename the summed column. fips==25410 for Baltimore City, MD.
Data <- NEI[fips=='24510',sum(Emissions), by=year]
names(Data)[2] <- 'TotalEmissions'

#open the plot
png("plot2.png", width = 480, height = 480)

#Develop the plot
plot(Data$year, Data$TotalEmissions, type = "b", pch = 25, col = "red", lwd=2,
     ylab = "Emissions (in tons)", xlab = "Year", main = "Total Baltimore City PM2.5 Emissions 1999 to 2008")
dev.off()

