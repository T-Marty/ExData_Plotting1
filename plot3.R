
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

### Create Plot 3 ###
png(filename = "plot3.png", width = 480, height = 480)
plot(dt$DateTime, dt$Sub_metering_1, col="black", ylab="Energy sub metering",
     xlab="", type='l')
lines(dt$DateTime, dt$Sub_metering_2, col="red", type='l')
lines(dt$DateTime, dt$Sub_metering_3, col="blue",type='l')
legend(x="topright", legend=names(dt)[6:8], lty=c(1,1,1), col=c("black", "red", "blue"))
dev.off()

