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

hist(as.numeric(sub2$Global_active_power), 
     xlab = "Global Active Power (kilowatts)", 
     col = "orangered", 
     ylab = "Frequency", 
     main = "Global Active Power")
## creates a histogram with the appropriate labeling 

dev.copy(png, file = "./plot1.png") ## creates png file
dev.off() ## resets graphics device