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