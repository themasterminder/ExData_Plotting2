##Question 3
#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
#variable, which of these four sources have seen decreases in emissions from 1999–2008 
#for Baltimore City? Which have seen increases in emissions from 1999–2008? 
#Use the ggplot2 plotting system to make a plot answer this question.


## Need to extract and unzip files
library(plyr)
file <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(file, destfile = "C:/Users/kenny.c.mcdowell/Documents/Coursera Courses/Exploratory Data Analysis/Course Project 2/NEI_data.zip"
              ,method = "curl")

## Unzip the file
unzip(zipfile = "C:/Users/kenny.c.mcdowell/Documents/Coursera Courses/Exploratory Data Analysis/Course Project 2/NEI_data.zip"
      ,exdir = "C:/Users/kenny.c.mcdowell/Documents/Coursera Courses/Exploratory Data Analysis/Course Project 2")

## Check to see that the files were unzipped into the correctly
list.files("C:/Users/kenny.c.mcdowell/Documents/Coursera Courses/Exploratory Data Analysis/Course Project 2")

## Read in emissions data and classification codes 
emissions <- readRDS("summarySCC_PM25.rds")
classcodes <- readRDS("Source_Classification_Code.rds")

library(tidyverse)
## summarize the PM25 emissions data by year
baltsumbytype <- emissions %>% 
  filter(Pollutant == "PM25-PRI") %>% 
  filter(fips == "24510") %>%
  select(year, type, Emissions) %>% 
  group_by(year, type) %>%
  summarise(sum = sum(Emissions))

install.packages("ggthemes")
library(ggthemes)
 
##Create plot3
par("mar"= c(5.1, 4.5, 4.1, 2.1))
png(filename = "plot3.png", width = 480, height = 480, units = "px")
ggplot(baltsumbytype, aes(year, sum, colour = type)) +
  geom_line(size= 1.5) + geom_point(shape = 20, size= 2) + 
  labs(title = "Total PM2.5 Emissions by Type In Baltimore City",
      x = "Year", y= "Total Emissions") +
     scale_color_discrete(name = "Source Type") +
  theme_economist(base_size = 10) 
dev.off()
