#Downloading and extracting the data

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

unzip(download.file(url, "./household.zip"))

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

hist(household_final$Global_active_power, breaks = 15, col="Orange", xlab="Global Active Power(kilowatts)", main=title("Global Active Power"))

dev.copy(png, file="Plot1.png")

dev.off()
