### Exploratory Data Analysis - Project 1
# Plot 4

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

# Plot 4 
par(mfrow = c(2, 2), mar=c(4,4,1,1), oma=c(0,0,1,0))
with(data, {
  plot(Global_active_power ~ day_time, xlab = "", ylab = "Global Active Power", type = "l")
  plot(Voltage ~ day_time, xlab = "dateime", ylab = "voltage", type = "l")
  plot(Sub_metering_1 ~ day_time, xlab = "", ylab = "Global Active Power(kilowatts)", type = "l")
  lines(Sub_metering_2 ~ day_time, col = "red") # joining the points
  lines(Sub_metering_3 ~ day_time, col = "blue")
  legend("topright", col = c("black", "red", "blue"), lwd=c(2,2,2), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.6)
  plot(Global_reactive_power ~ day_time, xlab = "daytime", type = "l")
})
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
