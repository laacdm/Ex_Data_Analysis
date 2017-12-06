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

par(mfrow = c(2, 2))
with(powCons, {
        plot(Date_Time,Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
        plot(Date_Time,Voltage, type = "l", ylab = "Voltage", xlab = "datetime")
        plot(Date_Time,Sub_metering_1,type = "l", ylab = "Energy sub metering", xlab = "", ylim = range(c(Sub_metering_1,Sub_metering_2,Sub_metering_3)))
        par(new=TRUE)
        plot(Date_Time,Sub_metering_2,type = "l", ylab = "", xlab = "", col = "red", ylim = range(c(Sub_metering_1,Sub_metering_2,Sub_metering_3)))
        par(new=TRUE)
        plot(Date_Time,Sub_metering_3,type = "l", ylab = "", xlab = "", col = "blue", ylim = range(c(Sub_metering_1,Sub_metering_2,Sub_metering_3)))
        legend("topright", lty = c(1,1,1), col = c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), inset = 0.1, adj = c(0, 0.5), cex = 0.8, bty = "n")
        plot(Date_Time,Global_reactive_power, type = "l", xlab = "datetime")
})

dev.copy(png, file = "plot4.png")
dev.off(4)