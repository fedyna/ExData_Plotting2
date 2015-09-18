#Compare emissions from motor vehicle sources in Baltimore City with emissions 
#from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?
library(plyr)
library(ggplot2)
NEI <- readRDS("~/exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("~/exdata-data-NEI_data/Source_Classification_Code.rds")
#subseting the motor vehicles in SCC.EI.Sector
vehicleSCC <- grepl("vehicle", SCC$EI.Sector, ignore.case=TRUE)
SCC_MV <- SCC[vehicleSCC, ]
NEI_MV <- NEI[NEI$SCC %in% SCC_MV$SCC, ]
#subseting NEI motor vehicles data in Baltimore and Los Angeles
NEI_MV_BC <- NEI_MV[NEI_MV$fips == "24510", ]
NEI_MV_LA <- NEI_MV[NEI_MV$fips == "06037", ]
#adding new variable - city 
NEI_MV_BC$city <- "Baltimore City"
NEI_MV_LA$city <- "Los Angeles County"
#joining tables
bothNEI <- rbind(NEI_MV_BC, NEI_MV_LA)
#open graphics device
png(filename = "~/exdata-data-NEI_data/plot6.png", width = 700, height = 480, units = "px")
#plotting (in year) how emissions changed from motor vehicle sources in Baltimore & LA
ggplot(bothNEI, aes(x = factor(year), y = Emissions, fill = city)) +
        geom_bar(stat="identity") +
        facet_grid(. ~ city) +
        labs(x = "Year", y = expression("Total PM"[2.5]*" Emission (Tons)")) + 
        labs(title = expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore / Los Angeles"))
#close graphics device
dev.off()