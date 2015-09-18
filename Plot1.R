#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
#Using the base plotting system, make a plot showing the total PM2.5 emission 
#from all sources for each of the years 1999, 2002, 2005, and 2008.

library(plyr)

NEI <- readRDS("~/exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("~/exdata-data-NEI_data/Source_Classification_Code.rds")

# aggregate the total PM2.5 emission for each of the years
aggDATA <- aggregate(Emissions ~ year, NEI, sum)
aggDATA_mega <- mutate(aggDATA, Emissions_mega = Emissions/10^6)
#   year Emissions Emissions_Mega
# 1 1999   7332967       7.332967
# 2 2002   5635780       5.635780
# 3 2005   5454703       5.454703
# 4 2008   3464206       3.464206
#open graphics device
png(filename = "~/exdata-data-NEI_data/plot1.png", width = 480, height = 480, units = "px")

barplot(aggDATA_mega$Emissions_mega, 
        xlab="Year", 
        ylab=expression("Total Emissions, (megaTons) PM"[2.5]),
        main="Total Emissions PM in the United States",  
        names.arg=aggDATA_mega$year, col = "dark red")
#close graphics device
dev.off()