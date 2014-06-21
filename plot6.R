library(ggplot2)
library(reshape2)
# Read RDS files to dataframes.
# NEI = National Emissions Data 
# SCC = Source Classification Code Table
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

nei$year <- as.factor(nei$year) # convert years from int to factors

nei.baltimore <- nei[nei$fips == "24510",] # subset data to Baltimore FIPS 24510

onroad <- as.vector(scc$SCC[scc$Data.Category == "Onroad"]) # obtain vector of SCC identifers that are onroad

df <- nei.baltimore[nei.baltimore$SCC %in% onroad,] # subset NEI data to those that are motor vehicles
total.pm25 <- tapply(df$Emissions, df$year, sum) # create table of aggregate pm25 data by year

barplot(total.pm25, yaxt="n", main="Baltimore, MD \nTons of PM2.5 Emissions from Motor Vehicles", xlab="Year", ylab="Tons")
axis(2, axTicks(2), format(axTicks(2), scientific = FALSE))

dev.copy(png, file="plot5.png")
dev.off()

