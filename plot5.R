##Question 5
##How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

## Need to extract and unzip files
library(plyr)
file <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(file, destfile = "C:/Users/kenny.c.mcdowell/Documents/Coursera Courses/Exploratory Data Analysis/Course Project 2/NEI_data.zip"
              ,method = "curl")

## Unzip the file
unzip(zipfile = "C:/Users/kenny.c.mcdowell/Documents/Coursera Courses/Exploratory Data Analysis/Course Project 2/NEI_data.zip"
      ,exdir = "C:/Users/kenny.c.mcdowell/Documents/Coursera Courses/Exploratory Data Analysis/Project 2")

## Check to see that the files were unzipped into the correctly
list.files("C:/Users/kenny.c.mcdowell/Documents/Coursera Courses/Exploratory Data Analysis/Course Project 2")

## Read in emissions data and classification codes 
emissions <- readRDS("summarySCC_PM25.rds")
classcodes <- readRDS("Source_Classification_Code.rds")

library(tidyverse)

## Merge emissions dataset with classcodes dataset
tot <- merge(emissions, classcodes, by="SCC", all = T)

baltmotor <- tot %>% 
  filter(str_detect(Short.Name, "Motor")) %>%
  filter(fips == "24510") %>% 
  select(year, Emissions) %>% 
  group_by(year) %>%
  summarise(sum = sum(Emissions))

install.packages("ggthemes")
library(ggthemes)

##Create plot5
par("mar"= c(5.1, 4.5, 4.1, 2.1))
png(filename = "plot5.png", width = 480, height = 480, units = "px")
ggplot(baltmotor, aes(year, sum)) +
  geom_line(size= 1.5) + geom_point(shape = 20, size= 2) + 
  labs(title = "Emissions from Motor-Vehicle Sources 
       in Baltimore City from 1999 to 2008",
       x = "Year", y= "Total Emissions") +
theme_economist(base_size = 10)
dev.off()
  