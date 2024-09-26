# Load necessary packages
library(data.table)  # for fread
library(lubridate)

# Specify the file path
file_path <- "household_power_consumption.txt"

# Read the data, specifying the separator, handling missing values, and filtering for the dates
data <- fread(file_path, sep = ";", na.strings = "?")[Date %in% c("1/2/2007", "2/2/2007")]

# Combine Date and Time into a POSIXct datetime
data[, DateTime := dmy_hms(paste(Date, Time))]

# Convert 'Global_active_power' to numeric, forcing any invalid values to NA
data$Global_active_power[data$Global_active_power == "?"] <- NA
data[, Global_active_power := as.numeric(Global_active_power)]

# Remove rows with NA values in DateTime or Global_active_power
clean_data <- na.omit(data)


# Set up the PNG device to save the plot
png("plot2.png", width = 480, height = 480)
# Plot Global Active Power vs DateTime
plot(clean_data$DateTime, clean_data$Global_active_power, 
     type = "l",    # Line plot
     xlab = "DateTime", 
     ylab = "Global Active Power (kilowatts)", 
     main = "Global Active Power vs DateTime",
     xaxt = "n",
     lwd = 2)       # Line width

axis.POSIXct(1, data$DateTime, format = "%a")

dev.off()