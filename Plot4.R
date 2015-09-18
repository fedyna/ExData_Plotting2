#Across the United States, 
#how have emissions from coal combustion-related sources changed from 1999–2008?
library(plyr)
library(ggplot2)
NEI <- readRDS("~/exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("~/exdata-data-NEI_data/Source_Classification_Code.rds")

# find all the coal combustion related sources (SCC)
# information from http://www3.epa.gov/air/emissions/basic.htm
CoalCombSources1 <- SCC[SCC$EI.Sector == "Fuel Comb - Comm/Institutional - Coal", ]
CoalCombSources2 <- SCC[SCC$EI.Sector == "Fuel Comb - Electric Generation - Coal", ]
CoalCombSources3 <- SCC[SCC$EI.Sector == "Fuel Comb - Industrial Boilers, ICEs - Coal", ]
CoalCombSources <- rbind(CoalCombSources1, CoalCombSources2, CoalCombSources3)

# subset emissions from coal combustion sources (NEI)
EmissionFromCoal <- NEI[NEI$SCC %in% CoalCombSources$SCC, ]

# year coal emissions (accross the USA)
YearCoalEmissions <- tapply(EmissionFromCoal$Emissions, EmissionFromCoal$year, sum)
#1999     2002     2005     2008 
#572126.5 546789.2 552881.5 343432.2 
#open graphics device
png(filename = "~/exdata-data-NEI_data/plot4.png", width = 480, height = 480, units = "px")
#Plotting (in year) how emissions changed from coal combustion
barplot(YearCoalEmissions/10^3, 
        xlab = "Year", 
        ylab = expression("Total Emissions PM"[2.5]*" (kilotons)"),
        main = expression("Coal Combustion Emissions Across US (1999-2008) related source"),  
        col = "dark grey")
#close graphics device
dev.off()