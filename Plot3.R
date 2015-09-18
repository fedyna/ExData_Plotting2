#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
#variable, which of these four sources have seen decreases in emissions from 1999–2008
#for Baltimore City? Which have seen increases in emissions from 1999–2008? 
#Use the ggplot2 plotting system to make a plot answer this question.
library(plyr)
library(ggplot2)
NEI <- readRDS("~/exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("~/exdata-data-NEI_data/Source_Classification_Code.rds")
#subsetting data on Baltimor city
NEI_Maryland <- NEI[NEI$fips==24510, ]
#open graphics device
png(filename = "~/exdata-data-NEI_data/plot3.png", width = 700, height = 480, units = "px")

ggplot(NEI_Maryland, aes(factor(year), Emissions, fill = type)) +
        geom_bar(stat = "identity") +
        facet_grid(. ~ type) +
        labs(x = "Year", y = expression("PM"[2.5]*" Emission (Tons)")) +
        labs(title = expression("Total Emissions PM"[2.5]*", in Baltimore City by Type"))
#close graphics device
dev.off()