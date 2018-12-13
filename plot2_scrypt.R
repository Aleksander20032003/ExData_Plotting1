### Exploratory Data Analysis - Project 1
# Plot 2

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

# Plot 2
plot(data$Global_active_power ~ data$day_time, type="l", xlab ="", ylab = "Global active power (kilowatts)")
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
