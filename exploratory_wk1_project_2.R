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

## (1) -----
par(mfrow=c(1,1))
  ## reset the plotting canvas

hist(as.numeric(sub2$Global_active_power), 
     xlab = "Global Active Power (kilowatts)", 
     col = "orangered", 
     ylab = "Frequency", 
     main = "Global Active Power")
  ## creates a histogram with the appropriate labeling 

dev.copy(png, file = "./plot1.png") ## creates png file
dev.off() ## resets graphics device

## (2) -----
par(mfrow=c(1,1))
## reset the plotting canvas

plot(as.numeric(sub2$Global_active_power) ~ sub2$datetime, 
     type = "n",
     ylab = "Global Active Power (kilowatts)",
     xlab = ""
     )
  ## creates the scatterplot, but doesn't print the data (type="n")

lines(sub2$datetime, sub2$Global_active_power, 
      type = "l")
  ## prints the line on the graph (type="l")

dev.copy(png, file = "./plot2.png") ## creates png file
dev.off() ## resets graphics device

## (3) -----
par(mfrow=c(1,1))
## reset the plotting canvas

sm1 <- as.numeric(sub2$Sub_metering_1)
sm2 <- as.numeric(sub2$Sub_metering_2)
sm3 <- as.numeric(sub2$Sub_metering_3)
  ## converts Sub_metering 1 through 3 into numeric values

plot(sm1 ~ sub2$datetime,
     type = "n",
     ylab = "Energy sub metering",
     xlab = "",
     cex.lab = 0.8,
     cex.axis = 0.8)

  ## creates the scatterplot with labels, no printing ("n")
  ## and decreases the size of the labels and axes

lines(sub2$datetime, sm1,
      type = "l",
      col = "black")
lines(sub2$datetime, sm2,
      type = "l",
      col = "red")
lines(sub2$datetime, sm3,
      type = "l",
      col = "blue")
  ## prints the lines for sm1, sm2, and sm3 with appropriate colors

legend("topright",
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lwd = 1,
       horiz = FALSE,
       cex = 0.8)
  ## creates the legend in the topright corner

dev.copy(png, file = "./plot3.png") ## creates png file
dev.off() ## resets graphics device

## (4) -----
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
