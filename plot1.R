
# Read RDS files to dataframes.
# NEI = National Emissions Data 
# SCC = Source Classification Code Table
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

nei$year <- as.factor(nei$year) # convert years from int to factors

total.pm25 <- tapply(nei$Emissions, nei$year, sum) # create table of aggregate pm25 data by year

# base barplot of total emissions and export to png
barplot(total.pm25, yaxt="n", main="Aggregate Tons of PM2.5 Emissions by Year", xlab="Year", ylab="Tons")
axis(2, axTicks(2), format(axTicks(2), scientific = FALSE))

dev.copy(png, file="plot1.png")
dev.off()