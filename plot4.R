library(ggplot2)
library(reshape2)
# Read RDS files to dataframes.
# NEI = National Emissions Data 
# SCC = Source Classification Code Table
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

nei$year <- as.factor(nei$year) # convert years from int to factors

coal <- scc[grep("Coal", scc$SCC.Level.Three),] # subset SCC table to Coal sources
coalcomb <- coal[grep("Combustion", coal$SCC.Level.One),] # subset Coal SCC table to Combustion sources
valid <- as.vector(coalcomb$SCC) # obtain vector of SCC identifers that are coal and combustion sources

df <- nei[nei$SCC %in% valid,] # subset NEI data to those that are coal and combusion by SCC id
total.pm25 <- tapply(df$Emissions, df$year, sum) # create table of aggregate pm25 data by year

barplot(total.pm25, yaxt="n", main="Tons of PM2.5 Emissions from Coal Combustion", xlab="Year", ylab="Tons")
axis(2, axTicks(2), format(axTicks(2), scientific = FALSE))

dev.copy(png, file="plot4.png")
dev.off()

