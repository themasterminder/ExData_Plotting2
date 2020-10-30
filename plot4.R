##Question 4 Across the United States, how have emissions from coal combustion-related 
##sources changed from 1999–2008?

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

## Merge emissions dataset with classcodes dataset
tot <- merge(emissions, classcodes, by="SCC", all = T)

 usacoal <- tot %>% 
  filter(str_detect(Short.Name, "Coal")) %>% 
  select(year, Emissions) %>% 
  group_by(year) %>%
  summarise(sum = sum(Emissions))

install.packages("ggthemes")
library(ggthemes)

##Create plot4
par("mar"= c(5.1, 4.5, 4.1, 2.1))
png(filename = "plot4.png", width = 480, height = 480, units = "px")
ggplot(usacoal, aes(year, sum)) +
  geom_line(size= 1.5) + geom_point(shape = 20, size= 2) + 
  labs(title = "Total Emissions from Coal-Combustion Related Sources 
                               in the United States",
       x = "Year", y= "Total Emissions") +
  theme_economist(base_size = 10) 
  dev.off()
