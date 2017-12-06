library(lubridate)
library(dplyr)

# Set your working directory
setwd("C:/Users/luis-alaniz/Desktop/Exploratory Data Analysis/Week1/")

# Download the data if it is not already in your working directory
if (!file.exists("power_cons.zip") & !file.exists("power_cons")) {
        fileurl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileurl, "power_cons.zip")
        dateDownloaded <- date()
        unzip("power_cons.zip", exdir = "power_cons")
}

powCons <- read.table("power_cons/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?") 
powCons <- tbl_df(powCons)
powCons <- mutate(powCons, Date = dmy(Date, tz = "UTC")) %>%
        mutate(Time = hms(Time), tz = "UTC") %>%
        mutate(Date_Time = Date + Time) %>%
        mutate(Date = as.character(Date)) %>%
        filter(Date == "2007-02-01" | Date == "2007-02-02") %>%
        select(-Date,-Time,-tz)

with(powCons,hist(Global_active_power, col = "Red", xlab = "Global Active Power (kilowats)",main = "Global Active Power"))

dev.copy(png, file = "plot1.png")
dev.off(4)