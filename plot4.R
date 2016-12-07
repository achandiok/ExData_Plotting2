#QUESTION4
#Across the United States, how have emissions from coal combustion-related sources changed from 1999 to 2008?

# Set the path for the data directory
setwd("C:/Users/ASHISH/Desktop/Cognitive Research/Coursera/DataScienceSpecialization/ExData_Plotting2/")

# Load Library
library(data.table)
library(ggplot2)

# Read the data file, and convert it to a data table.
NEI <- data.table(readRDS('summarySCC_PM25.rds'))
SCC <- data.table(readRDS('Source_Classification_Code.rds'))

# Find the pollution source codes for coal combustion-related sources.
SCCsubset <- SCC[EI.Sector %like% 'Coal$']

# Subset the full NEI dataset for coal combustion-related sources, only.
NEIsubset <- NEI[SCC %in% SCCsubset$SCC]

# Sum the emissions.
Data <- NEIsubset[,sum(Emissions), by=year]
names(Data)[2] <- 'TotalEmissions'

# Reduce the y-axis scale.
Data[,TotalEmissions := TotalEmissions / 1000]

# Develop the Plot
png("plot4.png", width = 480, height = 480)
g=ggplot(Data, aes(year, TotalEmissions))
g + geom_point(color = "black") + geom_line(color = "blue") + labs(x = "Year") + 
  labs(y = expression("Total Emissions of PM[2.5] (in thousands of tons)" )) + labs(title = "Emissions from Coal Combustion for the US")
dev.off()

