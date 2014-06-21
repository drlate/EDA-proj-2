library(ggplot2)
library(reshape2)
# Read RDS files to dataframes.
# NEI = National Emissions Data 
# SCC = Source Classification Code Table
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

nei$year <- as.factor(nei$year) # convert years from int to factors

nei.baltimore <- nei[nei$fips == "24510",] # subset data to Baltimore FIPS 24510

# use reshape2's melt function and dcast to summary table by emission type and year
dfmelt<-melt(nei.baltimore, id.vars = c("type", "year"), measure.vars = "Emissions")
df <- aggregate(. ~ type + year, data=dfmelt, FUN=sum)

ggplot(df, aes(x=year, y=value)) + geom_bar(stat="identity") + facet_wrap(~ type) + 
    labs(title="Baltimore, MD Aggregate Tons of PM2.5 Emissions") + ylab("Tons")

dev.copy(png, file="plot3.png")
dev.off()