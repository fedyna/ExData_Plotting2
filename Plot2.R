#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
#from 1999 to 2008? Use the base plotting system to make a plot answering this question

library(plyr)

NEI <- readRDS("~/exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("~/exdata-data-NEI_data/Source_Classification_Code.rds")

# aggregate the total PM2.5 emission for each of the years
NEI_Maryland <- NEI[NEI$fips==24510, ]
aggDATA <- aggregate(Emissions ~ year, NEI_Maryland, sum)
aggDATA_kilo <- mutate(aggDATA, Emissions_kilo = Emissions/10^3)
#  year Emissions Emissions_kilo
#1 1999  3274.180       3.274180
#2 2002  2453.916       2.453916
#3 2005  3091.354       3.091354
#4 2008  1862.282       1.862282
#open graphics device
png(filename = "~/exdata-data-NEI_data/plot2.png", width = 480, height = 480, units = "px")

barplot(aggDATA_kilo$Emissions_kilo, 
        xlab="Year", 
        ylab=expression("Total Emissions, (kiloTons) PM"[2.5]),
        main="Total Emissions PM in the Baltimore City, Maryland",  
        names.arg=aggDATA_kilo$year, col = "dark red")
#close graphics device
dev.off()