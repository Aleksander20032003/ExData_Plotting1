### Exploratory Data Analysis - Project 1
# Plot 3

### Loading the data

# Setting the working directory
setwd("C:/Users/Aleksander/Desktop/Exploratory Data Analysis")

# calculating how much memory the dataset will require
round(2075259 * 9  *8 / 2^{20}/1024, 2) # 2,075,259 rows, 9 columns and 8 bytes for one information

# Load the file
data_all <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", 
                       colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
# Changing the Data and Time variable from factor to date and time format
data_all$Date <- as.Date(data_all$Date, format = "%d/%m/%Y")

# filter the data for 2007-02-01 and 2007-02-02
data <- subset(data_all, Date == "2007-02-01" | Date == "2007-02-02")

# Creating day time variable
day_time <- paste(data$Date, data$Time) # creating a value
day_time <- setNames(day_time, "Day Time") #naming
data <- cbind(day_time, data) # binding with the data set
data$day_time <- as.POSIXct(day_time) # converging the type 

# Plot 3
par(mfrow = c(1, 1))
with(data, {
  plot(Sub_metering_1 ~ day_time, xlab = "", ylab = "Energy sub metering", type = "l")
  lines(Sub_metering_2 ~ day_time, col = "red") # joining the points
  lines(Sub_metering_3 ~ day_time, col = "blue")
  legend("topright", col = c("black", "red", "blue"), lwd=c(1,1,1), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),cex = 0.75 )
})
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
