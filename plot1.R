# Loading the data in from 2007-02-01 and 2007-02-02
# Load necessary packages
library(data.table)

# Specify the file path
file_path <- "household_power_consumption.txt"

# Read the data, specifying the separator, handling missing values, and filtering for the dates
data <- fread(file_path, sep = ";", na.strings = "?",
              colClasses = list(character = "Date"))[
                Date == "1/2/2007" | Date == "2/2/2007"]

# Convert 'Date' to Date class
data[, Date := as.Date(Date, format = "%d/%m/%Y")]
print(head(data))

names(data)


# Making Plot1

# Set up the PNG device to save the plot
png("plot1.png", width = 480, height = 480)

# Create the histogram
hist(data$Global_reactive_power, 
     col = "red",            # Color of the bars
     main = "Global Active Power",  # Title of the histogram
     xlab = "Global Active Power (kilowatts)", # X-axis label
     ylab = "Frequency"      # Y-axis label
)

dev.off()

