library(lubridate)
data2 <- read.csv("./household_power_consumption.txt", 
                  sep = ";", 
                  stringsAsFactors = FALSE)
summary(data2)
data2$Date <- dmy(data2$Date)
## converts the data to a "date" class with the lubridate package
sub2 <- data2[data2$Date > ymd(20070131) & data2$Date < ymd(20070203), ]
## using lubridate, filters the appropriate dates for our data
sub2$datetime <- ymd_hms(paste(sub2$Date, sub2$Time))
## using lubridate, creates new variable with time and date combined
par(mfrow = c(2, 2), oma = c(3, 1, 1, 1), mar = c(2, 4, 3, 1))
## sets the canvas to the appropriate dimensions

## Top-Left Graph, just like plot 2, but with smaller labels

plot(as.numeric(sub2$Global_active_power) ~ sub2$datetime, 
     type = "n",
     ylab = "Global Active Power (kilowatts)",
     xlab = "",
     cex.axis = 0.75,
     cex.lab = 0.75
)

lines(sub2$datetime, sub2$Global_active_power, 
      type = "l")

## Top-Right graph, plotting datetime against voltage

voltage <- as.numeric(sub2$Voltage)
plot(voltage ~ sub2$datetime,
     type = "n",
     ylab = "Voltage",
     xlab = "datetime", 
     cex.axis = 0.75, 
     cex.lab = 0.75)
##creates a blank plot with the correct labels 

lines(sub2$datetime, voltage)
## creates the line in the graph

## Bottom-Left graph, just like plot 3 but without a box around the legend

plot(sm1 ~ sub2$datetime,
     type = "n",
     ylab = "Energy sub metering",
     xlab = "",
     cex.lab = 0.75,
     cex.axis = 0.75)

lines(sub2$datetime, sm1,
      type = "l",
      col = "black")
lines(sub2$datetime, sm2,
      type = "l",
      col = "red")
lines(sub2$datetime, sm3,
      type = "l",
      col = "blue")

legend("topright",
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lwd = 1,
       horiz = FALSE,
       cex = 0.6,
       bty = "n",
       box.lwd = 0)

## Bottom-Right, Global Reactive Power vs datetime

gReactive <- as.numeric(sub2$Global_reactive_power)
plot(gReactive ~ sub2$datetime,
     type = "n",
     ylab = "Global_reactive_power",
     xlab = "datetime",
     cex.axis = 0.75,
     cex.lab = 0.75)
lines(sub2$datetime, gReactive)

dev.copy(png, file = "./plot4.png") ## creates png file
dev.off() ## resets graphics device
