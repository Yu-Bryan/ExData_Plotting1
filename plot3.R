library(data.table)

file        <- 'household_power_consumption.txt'
fromDate    <- as.Date('01/02/2007','%m/%d/%Y')
toDate      <- as.Date('02/02/2007','%m/%d/%Y')
fromDateTime <- strptime(paste(fromDate,'00:00:00'), format='%Y-%m-%d %T')
toDateTime  <- strptime(paste(toDate,'23:59:59'), format='%Y-%m-%d %T')
df          <- read.table(file,sep=';',header=TRUE);

subset      <- df[as.Date(df$Date, '%d/%m/%Y') == as.Date('02/01/2007','%m/%d/%Y') | as.Date(df$Date,'%d/%m/%Y') == as.Date('02/02/2007','%m/%d/%Y'),]

#Grah 3
xlab    <- ''
ylab    <- 'Energy sub meeting'
main    <- ''
xmin    <- min(strptime(paste(subset$Date,subset$Time),format='%d/%m/%Y %T'))
xmax    <- max(strptime(paste(subset$Date,subset$Time),format='%d/%m/%Y %T'))
ymin    <- 0
y1max   <- max(as.numeric(as.character(subset$Sub_metering_1)))
y2max   <- max(as.numeric(as.character(subset$Sub_metering_2)))
y3max   <- max(as.numeric(as.character(subset$Sub_metering_3)))
ymax    <- max(y1max,y2max,y3max)

#Plotting
plot(range(xmin,xmax),range(ymin,ymax),xlab=xlab,ylab=ylab,main=main,type='n')
legend('topright',legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'), col=c('black','red','blue'),lty=c(1,1,1))
lines(strptime(paste(subset$Date,subset$Time),format='%d/%m/%Y %T'),as.numeric(as.character(subset$Sub_metering_1)),xlab=xlab,ylab=ylab,main=main,col='black')
lines(strptime(paste(subset$Date,subset$Time),format='%d/%m/%Y %T'),as.numeric(as.character(subset$Sub_metering_2)),xlab=xlab,ylab=ylab,main=main,col='red')
lines(strptime(paste(subset$Date,subset$Time),format='%d/%m/%Y %T'),as.numeric(as.character(subset$Sub_metering_3)),xlab=xlab,ylab=ylab,main=main,col='blue')
dev.copy(png,'./plot3.png')
dev.off()
