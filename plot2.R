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