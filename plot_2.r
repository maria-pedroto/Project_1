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


#plot 2
plot(data$Global_active_power~data$Datetime, 
	 type="l",
     ylab="Global Active Power (kilowatts)", 
	 xlab="");

#saving
dev.copy(png, file="plot2.png", height=HEIGHT, width=WIDTH);
dev.off();