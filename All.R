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
dev.copy(png,'./figure/plot1.png')
dev.off()

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
dev.copy(png,'./figure/plot2.png')
dev.off()

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
dev.copy(png,'./figure/plot3.png')
dev.off()

#Graph 4
xlab    <- c('',
             'datetime',
             '',
             'datetime'
            )

ylab    <- c('Global Active Power',
             'Voltage',
             'Energy sub meeting',
             'Global_reactive_power'
            )

main    <- c('',
             '',
             '',
             ''
            )

xmin    <- c(min(strptime(paste(subset$Date,subset$Time),format='%d/%m/%Y %T')),
             min(strptime(paste(subset$Date,subset$Time),format='%d/%m/%Y %T')),
             min(strptime(paste(subset$Date,subset$Time),format='%d/%m/%Y %T')),
             min(strptime(paste(subset$Date,subset$Time),format='%d/%m/%Y %T'))
            )
xmax    <- c(max(strptime(paste(subset$Date,subset$Time),format='%d/%m/%Y %T')),
             max(strptime(paste(subset$Date,subset$Time),format='%d/%m/%Y %T')),
             max(strptime(paste(subset$Date,subset$Time),format='%d/%m/%Y %T')),
             max(strptime(paste(subset$Date,subset$Time),format='%d/%m/%Y %T'))
            )

ymin    <- c(0, 
             min(as.numeric(as.character(subset$Voltage))),
             0,
             0
            )

ymax_4_2<- c(max(as.numeric(as.character(subset$Sub_metering_1))),
              max(as.numeric(as.character(subset$Sub_metering_2))),
              max(as.numeric(as.character(subset$Sub_metering_3)))
            )

ymax    <- c(max(as.numeric(as.character(subset$Global_active_power))),
            max(as.numeric(as.character(subset$Voltage))),
            max(ymax_4_2),
            max(as.numeric(as.character(subset$Global_reactive_power)))
            )


par(mfrow = c(2,2))
plot(range(xmin[1],xmax[1]),range(ymin[1],ymax[1]),xlab=xlab[1],ylab=ylab[1],type='n')
lines(strptime(paste(subset$Date,subset$Time),format='%d/%m/%Y %T'),as.numeric(as.character(subset$Global_active_power)))

plot(range(xmin[2],xmax[2]),range(ymin[2],ymax[2]),xlab=xlab[2],ylab=ylab[2],type='n')
lines(strptime(paste(subset$Date,subset$Time),format='%d/%m/%Y %T'),as.numeric(as.character(subset$Voltage)))

plot(range(xmin[3],xmax[3]),range(ymin[3],ymax[3]),xlab=xlab[3],ylab=ylab[3],main=main[3],type='n')
legend('topright',legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'), col=c('black','red','blue'),lty=c(1,1,1))
lines(strptime(paste(subset$Date,subset$Time),format='%d/%m/%Y %T'),as.numeric(as.character(subset$Sub_metering_1)),col='black')
lines(strptime(paste(subset$Date,subset$Time),format='%d/%m/%Y %T'),as.numeric(as.character(subset$Sub_metering_2)),col='red')
lines(strptime(paste(subset$Date,subset$Time),format='%d/%m/%Y %T'),as.numeric(as.character(subset$Sub_metering_3)),col='blue')

plot(range(xmin[4],xmax[4]),range(ymin[4],ymax[4]),xlab=xlab[4],ylab=ylab[4],type='n')
lines(strptime(paste(subset$Date,subset$Time),format='%d/%m/%Y %T'),as.numeric(as.character(subset$Global_reactive_power)))

dev.copy(png,'./figure/plot4.png')
dev.off()
