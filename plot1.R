library(data.table)

file        <- 'household_power_consumption.txt'
fromDate    <- as.Date('01/02/2007','%m/%d/%Y')
toDate      <- as.Date('02/02/2007','%m/%d/%Y')
fromDateTime <- strptime(paste(fromDate,'00:00:00'), format='%Y-%m-%d %T')
toDateTime  <- strptime(paste(toDate,'23:59:59'), format='%Y-%m-%d %T')
df          <- read.table(file,sep=';',header=TRUE);

subset      <- df[as.Date(df$Date, '%d/%m/%Y') == as.Date('02/01/2007','%m/%d/%Y') | as.Date(df$Date,'%d/%m/%Y') == as.Date('02/02/2007','%m/%d/%Y'),]

#Graph 1
xlab    <- 'Global Active Power (kilowatts)'
ylab    <- 'Frequency'
main    <- 'Global Active Power'
hist(as.numeric(as.character(subset$Global_active_power)),col='red',xlab=xlab,ylab=ylab,main=main)
dev.copy(png,'./plot1.png')
dev.off()
