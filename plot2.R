
library(data.table)
library(dplyr)
library(stringr)

### Read and Process Data ###
dt <- read.table('household_power_consumption.txt',sep=";",
                 header = FALSE, skip = 66636, nrows = 2880)

names(dt) <- names(read.table('household_power_consumption.txt',sep=";",
                              header = TRUE, nrows = 1))

dt$Date <- as.Date(strptime(dt$Date, format = "%d/%m/%Y"))
dt$Time <- as.POSIXct(paste(dt$Date, dt$Time), format="%Y-%m-%d %H:%M:%S", tz='UTC')
dt <- dt[,2:9]
names(dt)[1] <- "DateTime"

### Create Plot 2 ###
png(filename = "plot2.png", width = 480, height = 480)
plot(dt$DateTime, dt$Global_active_power,xlab="", ylab = "Global Active Power (kilowatts)",
     type='l')
dev.off()

