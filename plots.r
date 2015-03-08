#constants
PATH <- '';
START_DATE <- "2007-02-01";
END_DATE <- "2007-02-02";
HEIGHT <- 480;
WIDTH <- 480; 

#working directory;
getwd();
setwd(PATH);

#read dataset
data_full <- read.csv(paste0(getwd(), "\\datasource\\household_power_consumption.txt"), 
					  header=T, 
					  sep=';', 
					  na.strings="?", 
                      nrows=2075259, 
					  check.names=F, 
					  stringsAsFactors=F, 
					  comment.char="", 
					  quote='\"')
					  
data_full$Date <- as.Date(data_full$Date, format="%d/%m/%Y");

#subsetting dataset 
data <- subset(data_full, subset=(Date >= START_DATE & Date <= END_DATE))
#memory management
rm(data_full);

#converting dates
datetime <- paste(as.Date(data$Date), data$Time);
data$Datetime <- as.POSIXct(datetime);

#plot 1
hist(data$Global_active_power, 
	 main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", 
	 ylab="Frequency", 
	 col="Red");

#saving
dev.copy(png, file="plot1.png", height=HEIGHT, width=WIDTH);
dev.off();

#plot 2
plot(data$Global_active_power~data$Datetime, 
	 type="l",
     ylab="Global Active Power (kilowatts)", 
	 xlab="");

#saving
dev.copy(png, file="plot2.png", height=HEIGHT, width=WIDTH);
dev.off();

#plot 3
plot(data$Sub_metering_1~data$Datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="");
lines(data$Sub_metering_2~data$Datetime,col='Red');
lines(data$Sub_metering_3~data$Datetime,col='Blue');
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"));

#saving
dev.copy(png, file="plot3.png", height=HEIGHT, width=WIDTH);
dev.off();

#plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
plot(data$Global_active_power~data$Datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="");
plot(data$Voltage~data$Datetime, type="l", ylab="Voltage (volt)", xlab="");
plot(data$Sub_metering_1~data$Datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="");
lines(data$Sub_metering_2~data$Datetime,col='Red');
lines(data$Sub_metering_3~data$Datetime,col='Blue');
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"));
plot(data$Global_reactive_power~data$Datetime, type="l", ylab="Global Rective Power (kilowatts)",xlab="");

#saving
dev.copy(png, file="plot4.png", height=HEIGHT, width=WIDTH)
dev.off()