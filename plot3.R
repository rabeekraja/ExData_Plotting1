# Assume household_power_consumption.txt is in the same directory as this r script
# Following R program plot line plot with legend with sub metering readings
# household_power_consumption.txt file having following columns with semi colon(;)  as separator
# and data not available as ?.
# Date;Time;Global_active_power;Global_reactive_power;Voltage;Global_intensity;Sub_metering_1;Sub_metering_2;Sub_metering_3
# 16/12/2006;17:24:00;4.216;0.418;234.840;18.400;0.000;1.000;17.000
library(dplyr)
# read consumption data into whole_data variable
# We need only subset of data between  2007-02-01 and 2007-02-02 - starts at 66638 and end at 69517 (2880 rows)
subset_data <- tbl_df(read.table("household_power_consumption.txt",skip = 66637,nrow=69517-66637, header=TRUE, sep= ";", na.strings = c("?","")))
#Since we removed column header - add it back for usage
colnames(subset_data) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
# convert date and time to proper formats given
subset_data$Date <- as.Date(subset_data$Date, format = "%d/%m/%Y")
subset_data$timetemp <- paste(subset_data$Date, subset_data$Time)
subset_data$Time <- strptime(subset_data$timetemp, format = "%Y-%m-%d %H:%M:%S")
# Create sub metering line plots as plot3.png
png(file = "plot3.png", width = 480, height = 480)
plot(x = subset_data$Time, y = subset_data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(x = subset_data$Time, y = subset_data$Sub_metering_2, type = "l", col = "red")
lines(x = subset_data$Time, y = subset_data$Sub_metering_3, type = "l", col = "blue")
#Add legend in topright corner
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#Close plotting device
dev.off()