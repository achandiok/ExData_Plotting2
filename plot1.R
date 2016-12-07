#QUESTION1
#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, 
#make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
#Upload a PNG file containing your plot addressing this question.

# Set the path for the directory
setwd("C:/Users/ASHISH/Desktop/Cognitive Research/Coursera/DataScienceSpecialization/ExData_Plotting2/")

# Load the Library
library(data.table)

# Read the data file, and convert it to a data table.
# Provide a suitable path for the data table
NEI <- data.table(readRDS('summarySCC_PM25.rds'))

# Summarize the PM2.5 emissions by year, and rename the summed column.
Data <- NEI[,sum(Emissions), by=year]
names(Data)[2] <- 'TotalEmissions'

# Reduce the y-axis scale.
Data[,TotalEmissions := TotalEmissions / 1000]

# Open the png plot device.
png("plot1.png", width = 480, height = 480)

# Create the plot.
plot(Data$year,Data$TotalEmissions, type='b', pch=25, col="blue", main='Total US PM2.5 Emissions 1999 to 2008', 
     xlab='Year', ylab='Emissions (in thousands of tons)', yaxs='r', xaxs='r', lwd=2, cex.axis=0.75)

# Close the plot device.
dev.off()


