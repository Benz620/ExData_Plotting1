#Loading the data 
data<- read.delim("household_power_consumption.txt",sep = ";")
library(data.table)
data<-data.table(data)
data1 <- data[Date%in%c("1/2/2007","2/2/2007"),]
data1$Global_active_power<-as.numeric(data1$Global_active_power)
View(data1)

## First, im trying to assemble the Date and time column into one clolumn called datetime by using the paste function
## then, im assigning it to a new variable calle data2
data2 <- data1[,datetime:= paste(data1$Date,data1$Time)]


## Second, im converteting  the datetime column which is a caracter string into date and time format using the strptime function
data2[,datetime:=strptime(data2$datetime, format = "%d/%m/%Y %H:%M:%S")]


png("plot3.png", width = 480,height = 480)

plot(data2$datetime, data2$Sub_metering_1, type ="l",xlab="",ylab="Global_reactive_power", xaxt="n")
lines(data2$datetime, data2$Sub_metering_2,col="red" ,type="l",xlab="",ylab="Global_reactive_power", xaxt="n")
lines(data2$datetime, data2$Sub_metering_3,col="blue" ,type="l",xlab="",ylab="Global_reactive_power", xaxt="n")
axis(side=1,seq(min(data2$datetime),max(data2$datetime),length=3),labels = c("Thu","Fri","Sat"))
legend("topright",lty=1, legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col = c("black","red","blue"))



dev.off()