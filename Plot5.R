#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

library(plyr)
library(ggplot2)
NEI <- readRDS("~/exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("~/exdata-data-NEI_data/Source_Classification_Code.rds")

#subsetting data on baltimore city (fips=24510) and "on-road" Type
NEIonRoad <- NEI[(NEI$fips=="24510") & (NEI$type=="ON-ROAD"), ]
#calculate the emissions due to motor vehicles in Baltimore city
YearVehiclesEmission <- tapply(NEIonRoad$Emissions, NEIonRoad$year, sum)
#1999      2002      2005      2008 
#346.82000 134.30882 130.43038 88.27546 

#open graphics device
png(filename = "~/exdata-data-NEI_data/plot5.png", width = 480, height = 480, units = "px")
#Plotting (in year) how emissions changed from motor vecicle sources
barplot(YearVehiclesEmission, xlab = "Year", col = "dark grey",
        ylab = expression("Total Emissions PM"[2.5]*" (tons)"), 
        main=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore (1999-2008)"))
#close graphics device
dev.off()
#same calculate by aggregate function as tapply
#aggData <- aggregate(NEIonRoad$Emissions, list(Year=NEIonRoad$year), sum)
