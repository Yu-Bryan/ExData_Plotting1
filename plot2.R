library(data.table)

file        <- 'household_power_consumption.txt'
fromDate    <- as.Date('01/02/2007','%m/%d/%Y')
toDate      <- as.Date('02/02/2007','%m/%d/%Y')
fromDateTime <- strptime(paste(fromDate,'00:00:00'), format='%Y-%m-%d %T')
toDateTime  <- strptime(paste(toDate,'23:59:59'), format='%Y-%m-%d %T')
df          <- read.table(file,sep=';',header=TRUE);

subset      <- df[as.Date(df$Date, '%d/%m/%Y') == as.Date('02/01/2007','%m/%d/%Y') | as.Date(df$Date,'%d/%m/%Y') == as.Date('02/02/2007','%m/%d/%Y'),]

#Graph 2
xlab    <- ''
ylab    <- 'Global Active Power (kilowatts)'
main    <- ''
xmin    <- min(strptime(paste(subset$Date,subset$Time),format='%d/%m/%Y %T'))
xmax    <- max(strptime(paste(subset$Date,subset$Time),format='%d/%m/%Y %T'))
ymin    <- 0
ymax    <- max(as.numeric(as.character(subset$Global_active_power)))
plot(range(xmin,xmax),range(ymin,ymax),xlab=xlab,ylab=ylab,main=main,type='n')
lines(strptime(paste(subset$Date,subset$Time),format='%d/%m/%Y %T'),as.numeric(as.character(subset$Global_active_power)))
dev.copy(png,'./plot2.png')
dev.off()
