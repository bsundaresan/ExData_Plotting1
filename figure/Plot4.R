#Read the data into R

household <- read.table("./household_power_consumption.txt", sep=";")

names(household) <- as.matrix(household[1,])

household <- household[-1,]

#Converting date into yyyy-mm-dd format and retrieving the required dates

household$Date <- as.Date(household$Date, format="%d/%m/%Y")

household1 <- household[household$Date=="2007-02-01", ]

household2 <- household[household$Date=="2007-02-02", ]

household_final <- rbind(household1, household2)

write.csv(household_final, "./household_final1.csv")

#Formating Date and Time

household_final$Date <- as.POSIXct(paste(household_final$Date, as.character(household_final$Time)))

#Converting factor values to numeric

index <- sapply(household_final, is.factor)

household_final[index] <- lapply(household_final[index], function(x) as.numeric(as.character(x)))

#Plotting histogram for Global_active_power

par(mfrow=c(2, 2))

plot(household_final$Date, household_final$Global_active_power, type = "l", xlab = "", ylab="Global Active Power (kilowatts)")

plot(household_final$Date, household_final$Voltage, type = "l", xlab="datetime", ylab="Voltage")

plot(household_final$Date, household_final$Sub_metering_1, type = "l", xlab = "", ylab="Energy sub metering")

lines(household_final$Date, household_final$Sub_metering_2, type = "l", col="red")

lines(household_final$Date, household_final$Sub_metering_3, type = "l", col="blue")

plot(household_final$Date, household_final$Global_reactive_power, type = "l", xlab = "datetime", ylab="Global Reactive Power (kilowatts)")

dev.copy(png, file="Plot4.png")

dev.off() 