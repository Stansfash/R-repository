# Loading the data in from 2007-02-01 and 2007-02-02
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
data[, Sub_metering_1 := as.numeric(Sub_metering_1)]
data[, Sub_metering_2 := as.numeric(Sub_metering_2)]
data[, Sub_metering_3 := as.numeric(Sub_metering_3)]

# Remove rows with NA values in any of the sub-metering columns
clean_data <- na.omit(data)

# Set up the PNG device to save the plot
png("plot3.png", width = 480, height = 480)
# Plot the three Sub_metering columns
plot(clean_data$DateTime, clean_data$Sub_metering_1, 
     type = "l", 
     col = "black", 
     xaxt = "n",
     xlab = "Days", 
     ylab = "Energy Sub Metering", 
     main = "Energy Consumption in Sub Meterings", 
     lwd = 2)  # Line width

# Add lines for the other two Sub_metering columns
lines(clean_data$DateTime, clean_data$Sub_metering_2, col = "red", lwd = 2)
lines(clean_data$DateTime, clean_data$Sub_metering_3, col = "blue", lwd = 2)

# Add a legend
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), 
       lty = 1, 
       lwd = 2)

axis.POSIXct(1, clean_data$DateTime, format = "%a")
dev.off()

