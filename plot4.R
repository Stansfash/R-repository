# Load necessary packages
library(data.table)
library(lubridate)

# Specify the file path
file_path <- "household_power_consumption.txt"

# Read the data, specifying the separator, handling missing values, and filtering for the dates
data <- fread(file_path, sep = ";", na.strings = "?")[ 
  Date == "1/2/2007" | Date == "2/2/2007"]

# Combine Date and Time into a POSIXct datetime if necessary
data[, DateTime := dmy_hms(paste(Date, Time))]

# Convert columns to numeric if they are not already
data[, Global_active_power := as.numeric(Global_active_power)]
data[, Voltage := as.numeric(Voltage)]
data[, Global_reactive_power := as.numeric(Global_reactive_power)]
data[, Sub_metering_1 := as.numeric(Sub_metering_1)]
data[, Sub_metering_2 := as.numeric(Sub_metering_2)]
data[, Sub_metering_3 := as.numeric(Sub_metering_3)]

# Remove rows with NA values in any of the necessary columns
clean_data <- na.omit(data)

# Set up the PNG device to save the plot
png("plot4.png", width = 480, height = 480)

# Set up a 2x2 plotting area
par(mfrow = c(2, 2))

# Top Left: Global Active Power vs DateTime
plot(clean_data$DateTime, clean_data$Global_active_power, 
     type = "l",    # Line plot
     xlab = "DateTime", 
     ylab = "Global Active Power (kilowatts)", 
     main = "Global Active Power vs DateTime",
     xaxt = "n",
     lwd = 2)       # Line width
axis.POSIXct(1, clean_data$DateTime, format = "%a")

# Top Right: Voltage vs DateTime
plot(clean_data$DateTime, clean_data$Voltage, 
     type = "l",    # Line plot
     xlab = "DateTime", 
     ylab = "Voltage (volts)", 
     main = "Voltage vs DateTime",
     xaxt = "n",
     lwd = 2)       # Line width
axis.POSIXct(1, clean_data$DateTime, format = "%a")

# Bottom Left: Sub Metering
plot(clean_data$DateTime, clean_data$Sub_metering_1, 
     type = "l", 
     col = "black", 
     xaxt = "n",
     xlab = "DateTime", 
     ylab = "Energy Sub Metering", 
     main = "Energy Consumption in Sub Meterings", 
     lwd = 2)  # Line width
lines(clean_data$DateTime, clean_data$Sub_metering_2, col = "red", lwd = 2)
lines(clean_data$DateTime, clean_data$Sub_metering_3, col = "blue", lwd = 2)
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), 
       lty = 1, 
       lwd = 2)
axis.POSIXct(1, clean_data$DateTime, format = "%a")

# Bottom Right: Global Reactive Power vs DateTime
plot(clean_data$DateTime, clean_data$Global_reactive_power, 
     type = "l",    # Line plot
     xlab = "DateTime", 
     ylab = "Global Reactive Power (kilowatts)", 
     main = "Global Reactive Power vs DateTime",
     xaxt = "n",
     lwd = 2)       # Line width
axis.POSIXct(1, clean_data$DateTime, format = "%a")

dev.off()
